import 'package:aurakart/features/chatbot/chatbot_screen.dart';
import 'package:aurakart/features/chatbot/controller/button_position_controller.dart';
import 'package:aurakart/features/shop/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatButton extends StatelessWidget {
  const ChatButton({super.key});

  @override
  Widget build(BuildContext context) {
    final positionController = Get.put(ButtonPositionController());
    final screenSize = MediaQuery.of(context).size;
    return // Draggable Chat Button
        Obx(
      () {
        return Positioned(
          left: positionController.buttonPosition.value.dx,
          top: positionController.buttonPosition.value.dy,
          child: Draggable(
            feedback: FloatingActionButton(
              onPressed: null,
              backgroundColor: Colors.blue.withValues(alpha: 0.5),
              child: const Icon(Icons.chat),
            ),
            childWhenDragging: const SizedBox(), // Placeholder when dragging
            child: FloatingActionButton(
              onPressed: () {
                // Navigate to ChatScreen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ChatPage(),
                  ),
                );
              },
              child: const Icon(Icons.chat),
            ),
            onDragEnd: (details) {
              // Update button position on drag end
              positionController.updatePosition(
                Offset(
                  details.offset.dx.clamp(0, screenSize.width - 56),
                  details.offset.dy.clamp(0, screenSize.height - 56),
                ),
                screenSize.width,
              );
            },
          ),
        );
      },
    );
  }
}
