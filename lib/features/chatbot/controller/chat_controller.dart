import 'package:aurakart/utils/helpers/network_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import '../models/chat_model.dart';

import 'package:aurakart/features/shop/controllers/product/product_controller.dart';

class ChatController extends GetxController {
  static ChatController get instance => Get.find();

  final promptController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  final RxList<ChatModel> messages = <ChatModel>[].obs;
  final RxBool isLoading = false.obs;

  ChatSession? _chatSession;
  String _currentModelName = 'gemini-3.5-flash'; // Changed to match the user's advanced API key

  final String _systemInstruction = '''
You are Dekozy's intelligent customer support AI. 
Dekozy is a premium furniture and home decor e-commerce app. 
Your personality: Concise, friendly, and helpful. You are an expert in interior design and Dekozy's catalog.

### OUR CATALOG & CATEGORIES:
- Living Room: Luxury Sofas, Sectionals, Coffee Tables, TV Stands, Lounge Chairs.
- Bedroom: Premium Beds, Mattresses, Nightstands, Dressers, Wardrobes.
- Dining: Dining Tables, Dining Chairs, Bar Stools, Sideboards.
- Lighting: Chandeliers, Floor Lamps, Table Lamps, Pendant Lights.
- Decor: Rugs, Mirrors, Vases, Wall Art, Cushions.

### OUR CORE FEATURES:
- AR/VR Viewer: Users can tap the "View in AR/VR" button on any product page to see exactly how the furniture fits in their room using their phone's camera!
- Seamless Checkout: We support Stripe (Credit/Debit Cards) and Cash on Delivery (COD).
- Personalization: Users can save items to their Wishlist, manage multiple shipping addresses, and track order status in real-time.

### RULES:
- STRICTLY DO NOT USE MARKDOWN. Do NOT use **asterisks** for bolding (e.g. write Dekozy, never **Dekozy**). Return plain text only.
- Focus entirely on helping users shop for furniture, recommend products based on their style, track orders, or explain how to use the AR/VR features. 
- Do not mention technical developer terms or UI architecture like "fluid navigation" or "themes".
- If a user asks a question unrelated to furniture, shopping, or support, politely guide them back to our store.
''';

  @override
  void onInit() {
    super.onInit();
    _initializeChatUI();

    ever(messages, (_) {
      Future.delayed(const Duration(milliseconds: 100), () {
        if (scrollController.hasClients) {
          scrollController.animateTo(
            scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      });
    });
  }

  void _initializeChatUI() {
    messages.clear();
    messages.add(
      ChatModel(
        isPrompt: false,
        message: "Hello! I'm Dekozy's AI assistant. How can I help you today?",
        time: DateTime.now(),
      ),
    );
    _chatSession = null; // Force a fresh session on next message
  }

  void _initSessionWithModel(String modelName, String apiKey) {
    try {
      final model = GenerativeModel(
        model: modelName,
        apiKey: apiKey,
      );

      String liveProductsContext = "";
      try {
        if (Get.isRegistered<ProductController>()) {
          final productCtrl = ProductController.instance;
          if (productCtrl.featuredProducts.isNotEmpty) {
            liveProductsContext = "\n\n### LIVE STORE INVENTORY (USE THIS TO RECOMMEND PRODUCTS):\nHere are the exact products currently available in the database, with their live prices.\n";
            for (var p in productCtrl.featuredProducts) {
              final price = productCtrl.getProductPrice(p);
              final stock = p.stock > 0 ? 'In Stock' : 'Out of Stock';
              liveProductsContext += "- ${p.title} (Brand: ${p.brand?.name ?? 'Dekozy'}) - Price: \$${price} - Status: $stock\n";
            }
          }
        }
      } catch (e) {
        debugPrint("Could not fetch live products for AI context: $e");
      }

      final completeSystemInstruction = _systemInstruction + liveProductsContext;

      // We pass the training instructions as the first hidden history context 
      // instead of using systemInstruction parameter, ensuring it works on ALL model versions.
      _chatSession = model.startChat(history: [
        Content.text('System Context: $completeSystemInstruction'),
        Content.model([TextPart('Understood. I am ready to help users of Dekozy.')]),
      ]);
      _currentModelName = modelName;
    } catch (e) {
      debugPrint('Error initializing session: \$e');
    }
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  Future<void> sendMessage() async {
    final message = promptController.text.trim();
    if (message.isEmpty) return;

    final key1 = dotenv.env['GEMINI_API_KEY_1'] ?? '';
    final key2 = dotenv.env['GEMINI_API_KEY_2'] ?? '';

    if (key1.isEmpty && key2.isEmpty) {
      messages.add(
        ChatModel(
          isPrompt: false,
          message: "My API keys are not configured yet! Please add GEMINI_API_KEY_1 to the .env file.",
          time: DateTime.now(),
        ),
      );
      return;
    }

    final activeKey = key1.isNotEmpty ? key1 : key2;

    messages.add(
      ChatModel(
        isPrompt: true,
        message: message,
        time: DateTime.now(),
      ),
    );

    promptController.clear();
    isLoading.value = true;

    try {
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        throw Exception("No internet connection.");
      }

      if (_chatSession == null) {
        _initSessionWithModel(_currentModelName, activeKey);
      }

      try {
        final response = await _chatSession?.sendMessage(Content.text(message));
        if (response != null && response.text != null) {
          messages.add(
            ChatModel(
              isPrompt: false,
              message: response.text!.trim(),
              time: DateTime.now(),
            ),
          );
        }
      } catch (e) {
        final errorString = e.toString().toLowerCase();
        
        // 1. Handle Model Not Found or 503 Overloaded Error (Fallback to gemini-3.5-flash-lite)
        if (errorString.contains('not found') || errorString.contains('not supported') || errorString.contains('503') || errorString.contains('unavailable')) {
          debugPrint("Model \$_currentModelName not supported or overloaded. Falling back to gemini-3.5-flash-lite...");
          _initSessionWithModel('gemini-3.5-flash-lite', activeKey);
          
          // Retry with gemini-3.5-flash-lite
          final retryResponse = await _chatSession?.sendMessage(Content.text(message));
          if (retryResponse != null && retryResponse.text != null) {
            messages.add(
              ChatModel(
                isPrompt: false,
                message: retryResponse.text!.trim(),
                time: DateTime.now(),
              ),
            );
          }
        } 
        // 2. Handle Rate Limit Error (Fallback to Key 2)
        else if (errorString.contains('429') && key2.isNotEmpty && key1.isNotEmpty) {
          debugPrint("Key 1 quota exceeded, falling back to Key 2...");
          _initSessionWithModel(_currentModelName, key2);
          
          final retryResponse = await _chatSession?.sendMessage(Content.text(message));
          if (retryResponse != null && retryResponse.text != null) {
            messages.add(
              ChatModel(
                isPrompt: false,
                message: retryResponse.text!.trim(),
                time: DateTime.now(),
              ),
            );
          }
        } else {
          debugPrint("============= GEMINI API ERROR =============\n$e\n=========================================");

          rethrow;
        }
      }
    } catch (e) {
      debugPrint("============= FINAL CAUGHT ERROR =============\n$e\n=========================================");

      messages.add(
        ChatModel(
          isPrompt: false,
          message: "Sorry, I couldn't process that right now. (\$e)",
          time: DateTime.now(),
        ),
      );
    } finally {
      isLoading.value = false;
    }
  }

  void clearChat() {
    _initializeChatUI();
  }
}
