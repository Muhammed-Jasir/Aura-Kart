import 'package:aurakart/common/widgets/appbar/appbar.dart';
import 'package:aurakart/features/chatbot/controller/chat_controller.dart';
import 'package:aurakart/features/chatbot/screen/chat/widgets/chat_bubble.dart';
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
    return Scaffold(
      appBar: AAppBar(
        title: const Text("Dekozy Chatbot"),
        showBackArrow: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              // Show info about chatbot
              Get.dialog(
                AlertDialog(
                  title: const Text("About"),
                  content: const Text(
                      "I'm here to help you with product information and shopping assistance."),
                  actions: [
                    TextButton(
                      onPressed: () => Get.back(),
                      child: const Text("OK"),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AImages.chatImage),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            // Chat Messages
            Expanded(
              child: Obx(
                () => ListView.builder(
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
                ),
              ),
            ),

            // Input Field
            Padding(
              padding: EdgeInsets.all(ASizes.md),
              child: Row(
                children: [
                  Expanded(
                    flex: 20,
                    child: TextField(
                      controller: controller.promptController,
                      style:
                          const TextStyle(fontSize: 18, color: Colors.black),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        hintText: "Type here...",
                        filled: true,
                        fillColor: Colors.white70,
                      ),
                    ),
                  ),
                  const SizedBox(width: ASizes.sm),
                  GestureDetector(
                    onTap: () => controller.sendMessage(),
                    child: const CircleAvatar(
                      radius: 28,
                      backgroundColor: Color(0xFFF78282),
                      child: Icon(Icons.send, color: Colors.white, size: 30),
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
}