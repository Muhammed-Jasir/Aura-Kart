import 'dart:ui';
import 'package:aurakart/features/chatbot/controller/chat_controller.dart';
import 'package:aurakart/features/chatbot/screen/widgets/chat_bubble.dart';
import 'package:aurakart/utils/constants/colors.dart';
import 'package:aurakart/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ChatbotScreen extends StatelessWidget {
  ChatbotScreen({super.key});

  final controller = Get.put(ChatController());

  @override
  Widget build(BuildContext context) {
    final darkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: darkMode ? const Color(0xFF121212) : const Color(0xFFF2F2F7),
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: AppBar(
              backgroundColor: darkMode 
                  ? Colors.black.withValues(alpha: 0.5) 
                  : Colors.white.withValues(alpha: 0.7),
              elevation: 0,
              centerTitle: true,
              title: ShaderMask(
                shaderCallback: (bounds) => const LinearGradient(
                  colors: [Color(0xFFFF6B6B), Color(0xFF4ECDC4), Color(0xFF45B7D1)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ).createShader(bounds),
                child: const Text(
                  'Dekozy AI',
                  style: TextStyle(
                    color: Colors.white, // Required for ShaderMask
                    fontWeight: FontWeight.w800,
                    fontSize: 22,
                    letterSpacing: -0.5,
                  ),
                ),
              ),
              automaticallyImplyLeading: false,
              actions: [
                IconButton(
                  icon: Icon(Icons.delete_outline, color: darkMode ? Colors.white70 : Colors.black87),
                  onPressed: () => controller.clearChat(),
                  tooltip: 'Clear chat',
                ),
                IconButton(
                  icon: Icon(Icons.info_outline, color: darkMode ? Colors.white70 : Colors.black87),
                  onPressed: () {
                    Get.dialog(
                      AlertDialog(
                        title: const Text('Dekozy Shopping Assistant'),
                        content: const Text(
                            'Ask me anything about our products, orders, or how to shop on Dekozy!'),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        actions: [
                          TextButton(
                              onPressed: () => Get.back(),
                              child: const Text('Got It')),
                        ],
                      ),
                    );
                  },
                  tooltip: 'About',
                ),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          // Chat Messages
          Expanded(
            child: Obx(
              () => ListView.builder(
                controller: controller.scrollController,
                padding: EdgeInsets.only(
                  left: ASizes.md,
                  right: ASizes.md,
                  top: kToolbarHeight + MediaQuery.of(context).padding.top + 20,
                  bottom: ASizes.md,
                ),
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

          // Typing indicator
          Obx(
            () => controller.isLoading.value
                ? Padding(
                    padding: const EdgeInsets.only(left: ASizes.md, bottom: 8),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(right: 8),
                            child: const CircleAvatar(
                              radius: 16,
                              backgroundColor: AColors.primary,
                              child: Icon(Icons.auto_awesome, color: Colors.white, size: 18),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 14,
                            ),
                            decoration: BoxDecoration(
                              color: darkMode ? const Color(0xFF2C2C2E) : Colors.white,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                                bottomRight: Radius.circular(20),
                                bottomLeft: Radius.circular(4),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.05),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                _buildAnimatedDot(0),
                                _buildAnimatedDot(1),
                                _buildAnimatedDot(2),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
          ),

          // Floating Input Field
          Padding(
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
              bottom: MediaQuery.of(context).padding.bottom + 16,
              top: 8,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: darkMode ? const Color(0xFF2C2C2E) : Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    spreadRadius: 0,
                    blurRadius: 20,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller.promptController,
                      style: TextStyle(
                          fontSize: 16,
                          color: darkMode ? Colors.white : Colors.black87),
                      decoration: InputDecoration(
                        hintText: 'Message...',
                        hintStyle: TextStyle(
                            color: darkMode ? Colors.white54 : Colors.black38),
                        filled: false,
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ),
                      onSubmitted: (_) => controller.sendMessage(),
                    ),
                  ),
                  ValueListenableBuilder<TextEditingValue>(
                    valueListenable: controller.promptController,
                    builder: (context, value, child) {
                      final hasText = value.text.trim().isNotEmpty;
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.easeOut,
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: hasText
                              ? const LinearGradient(
                                  colors: [Color(0xFF00C6FF), Color(0xFF0072FF)],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                )
                              : null,
                          color: hasText 
                              ? null 
                              : (darkMode ? Colors.grey[800] : Colors.grey[200]),
                        ),
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          icon: Icon(
                            Icons.arrow_upward_rounded,
                            color: hasText 
                                ? Colors.white 
                                : (darkMode ? Colors.grey[500] : Colors.grey[400]),
                            size: 22,
                          ),
                          onPressed: hasText ? () => controller.sendMessage() : null,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedDot(int index) {
    // A simple dot for now, you could add AnimationController for bouncing
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2),
      height: 6,
      width: 6,
      decoration: BoxDecoration(
        color: const Color(0xFF4ECDC4).withValues(alpha: 0.6),
        shape: BoxShape.circle,
      ),
    );
  }
}
