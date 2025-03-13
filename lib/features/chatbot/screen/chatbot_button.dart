import 'package:aurakart/features/chatbot/screen/chatbot_screen.dart';
import 'package:aurakart/features/chatbot/controller/chatbot_button_controller.dart';
import 'package:aurakart/features/shop/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatbotButton extends StatelessWidget {
  const ChatbotButton({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ChatbotButtonController());
    final screenSize = MediaQuery.of(context).size;

    const bottomNavHeight = 80.0;

    return Obx(
      () {
        if (!controller.isButtonVisible.value) {
          return const SizedBox();
        }
        return Stack(
          children: [
            Positioned(
              left: controller.buttonPosition.value.dx,
              top: controller.buttonPosition.value.dy,
              child: Draggable(
                // Button when dragging
                feedback: FloatingActionButton(
                  onPressed: null,
                  backgroundColor: Colors.blue.withValues(alpha: 0.5),
                  child: const Icon(Icons.chat),
                ),
                childWhenDragging: const SizedBox(),
                // Chat Button
                child: FloatingActionButton(
                  backgroundColor: Colors.blue,
                  onPressed: () => Get.to(() => const ChatbotScreen()),
                  child: const Icon(Icons.chat),
                ),
                onDragEnd: (details) {
                  // Get new position
                  final newDx =
                      details.offset.dx.clamp(16, screenSize.width - 56 - 16);
                  final newDy = details.offset.dy
                      .clamp(16, screenSize.height - bottomNavHeight - 56 - 16);

                  controller.updatePosition(
                    Offset(newDx.toDouble(), newDy.toDouble()),
                    screenSize.width,
                    screenSize.height
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
