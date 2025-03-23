import 'package:aurakart/common/widgets/appbar/appbar.dart';
import 'package:aurakart/features/chatbot/controller/chat_controller.dart';
import 'package:aurakart/features/chatbot/screen/widgets/chat_bubble.dart';
import 'package:aurakart/utils/constants/colors.dart';
import 'package:aurakart/utils/constants/image_strings.dart';
import 'package:aurakart/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ChatbotScreen extends StatelessWidget {
  ChatbotScreen({super.key});

  final controller = Get.put(ChatController());

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AImages.chatImage),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withValues(alpha: 0.1),
            BlendMode.darken,
          ),
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AAppBar(
          title: const Text("Dekozy Chatbot",
              style: TextStyle(fontWeight: FontWeight.bold)),
          showBackArrow: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.delete_outline),
              onPressed: () => controller.clearChat(),
              tooltip: "Clear chat",
            ),
            IconButton(
              icon: const Icon(Icons.info_outline),
              onPressed: () {
                // Show info about chatbot
                Get.dialog(
                  AlertDialog(
                    title: const Text("About Dekozy Chatbot"),
                    content: const Text(
                        "I'm here to help you with product information and shopping assistance."),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    actions: [
                      TextButton(
                        onPressed: () => Get.back(),
                        child: const Text("Got It")
                      ),
                    ],
                  ),
                );
              },
              tooltip: "About",
            ),
          ],
        ),
        body: Column(
          children: [
            // Chat Messages
            Expanded(
              child: Obx(
                () {
                  return ListView.builder(
                    padding: EdgeInsets.symmetric(
                        horizontal: ASizes.sm, vertical: ASizes.md),
                    itemCount: controller.messages.length,
                    itemBuilder: (context, index) {
                      final message = controller.messages[index];
                      return ChatBubble(
                        isPrompt: message.isPrompt,
                        message: message.message,
                        time: DateFormat('hh:mm a').format(message.time),
                      );
                    },
                  );
                },
              ),
            ),

            // Typing indicator
            Obx(
              () => controller.isLoading.value
                  ? Padding(
                      padding:
                          EdgeInsets.only(left: ASizes.md, bottom: ASizes.sm),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              _buildDot(),
                              _buildDot(),
                              _buildDot(),
                            ],
                          ),
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
            ),

            // Input Field
            Container(
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.9),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, -1),
                  ),
                ],
              ),
              padding: EdgeInsets.all(ASizes.md),
              child: Row(
                children: [
                  Expanded(
                    flex: 20,
                    child: TextField(
                      controller: controller.promptController,
                      style: const TextStyle(fontSize: 18, color: Colors.black),
                      decoration: InputDecoration(
                        hintText: "Type your message...",
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 14,
                        ),
                      ),
                      onSubmitted: (_) => controller.sendMessage(),
                    ),
                  ),
                  const SizedBox(width: ASizes.sm),
                  Material(
                    elevation: 4,
                    shape: const CircleBorder(),
                    child: GestureDetector(
                      onTap: () => controller.sendMessage(),
                      child: Container(
                        height: 48,
                        width: 48,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [Color(0xFF5C6BC0), Color(0xFF3949AB)],
                          ),
                        ),
                        child: const Icon(Icons.send, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDot() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2),
      height: 8,
      width: 8,
      decoration: const BoxDecoration(
        color: Colors.grey,
        shape: BoxShape.circle,
      ),
    );
  }
}
