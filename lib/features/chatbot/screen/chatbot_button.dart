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
                feedback: FloatingActionButton(
                  onPressed: null,
                  backgroundColor: Colors.blue.withValues(alpha: 0.5),
                  child: const Icon(Icons.chat),
                ),
                childWhenDragging: const SizedBox(),
                child: FloatingActionButton(
                  backgroundColor: Colors.blue,
                  onPressed: () => Get.to(() => const ChatbotScreen()),
                  child: const Icon(Icons.chat),
                ),
                onDragStarted: () {
                  controller.isDragging.value = true;
                },
                onDragEnd: (details) {
                  controller.isDragging.value = false;

                  // Get new position
                  final newDx =
                      details.offset.dx.clamp(0, screenSize.width - 56);
                  final newDy = details.offset.dy
                      .clamp(0, screenSize.height - bottomNavHeight - 56);

                  // Check if dropped in discard area
                  if (controller.isDragging.value &&
                      newDy > screenSize.height - bottomNavHeight - 100) {
                    controller.hideButton();
                  } else {
                    controller.updatePosition(
                      Offset(newDx.toDouble(), newDy.toDouble()),
                      screenSize.width,
                    );
                  }
                },
              ),
            ),
            if (controller.isDragging.value)
              Positioned(
                bottom: bottomNavHeight + 20,
                left: screenSize.width / 2 - 50,
                child: Container(
                  width: 100,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.red.withValues(alpha: 0.8),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: const Center(
                    child: Icon(Icons.delete, color: Colors.white, size: 30),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
