import 'dart:convert';

import 'package:aurakart/utils/constants/api_constants.dart';
import 'package:aurakart/utils/helpers/network_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:http/http.dart' as http;
import '../models/chat_model.dart';

class ChatController extends GetxController {
  static ChatController get instance => Get.find();

  final promptController = TextEditingController();
  final RxList<ChatModel> messages = <ChatModel>[].obs;
  final RxBool isLoading = false.obs;

  final String rasaUrl = APIConstants.rasaUrl;
  final Duration timeout = const Duration(seconds: 10);

  @override
  void onInit() {
    super.onInit();
    messages.add(
      ChatModel(
        isPrompt: false,
        message: "Hello! I'm Dekozy's assistant. How can I help you today?",
        time: DateTime.now(),
      ),
    );
  }

  Future<void> sendMessage() async {
    final message = promptController.text.trim();

    if (message.isEmpty) return;

    messages.add(
      ChatModel(
        isPrompt: true,
        message: message,
        time: DateTime.now(),
      ),
    );

    // Clear the input field
    promptController.clear();

    // Start Loader
    isLoading.value = true;

    try {
      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) return;

      // Send message to Rasa
      final response = await http
          .post(
            Uri.parse(rasaUrl),
            headers: {"Content-Type": "application/json"},
            body: jsonEncode({"sender": "user", "message": message}),
          )
          .timeout(timeout);

      if (response.statusCode == 200) {
        final List<dynamic> botResponses = jsonDecode(response.body);
        if (kDebugMode) {
          print(botResponses);
        }

        if (botResponses.isEmpty) {
          // Handle empty response
          messages.add(
            ChatModel(
              isPrompt: false,
              message:
                  "I'm not sure how to respond to that. Could you try rephrasing your question?",
              time: DateTime.now(),
            ),
          );
        } else {
          // Add bot responses
          for (var botMessage in botResponses) {
            messages.add(
              ChatModel(
                isPrompt: false,
                message: botMessage["text"] ?? "I didn't understand that.",
                time: DateTime.now(),
              ),
            );
          }
        }
      } else {
        // Add error message
        messages.add(
          ChatModel(
            isPrompt: false,
            message:
                "Error: Could not reach the chatbot. Please try again later.",
            time: DateTime.now(),
          ),
        );
      }
    } catch (e) {
      messages.add(
        ChatModel(
          isPrompt: false,
          message: "Error: ${e.toString()}",
          time: DateTime.now(),
        ),
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Method to clear chat history
  void clearChat() {
    messages.clear();
    // Add welcome message again
    messages.add(
      ChatModel(
        isPrompt: false,
        message: "Chat history cleared. How can I help you today?",
        time: DateTime.now(),
      ),
    );
  }
}
