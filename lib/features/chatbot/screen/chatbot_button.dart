import 'package:aurakart/features/chatbot/screen/chatbot_screen.dart';
import 'package:aurakart/features/chatbot/controller/chatbot_button_controller.dart';
import 'package:aurakart/features/shop/screens/home/home.dart';
import 'package:aurakart/utils/constants/colors.dart';
import 'package:aurakart/utils/device/device_utility.dart';
import 'package:aurakart/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ChatbotButton extends StatelessWidget {
  const ChatbotButton({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ChatbotButtonController());
    final screenSize = AHelperFunctions.screenSize();

    final bottomNavHeight = ADeviceUtils.getBottomNavigationBarHeight();

    return Obx(
      () {
        if (!controller.isButtonVisible.value) return const SizedBox();

        return Stack(
          children: [
            Positioned(
              left: controller.buttonPosition.value.dx,
              top: controller.buttonPosition.value.dy,
              child: Draggable(
                // Button when dragging
                feedback: FloatingActionButton(
                  onPressed: null,
                  backgroundColor: AColors.primary.withValues(alpha: 0.5),
                  child: Icon(Iconsax.message, color: Colors.white),
                ),
                childWhenDragging: const SizedBox(),
                // Chat Button
                child: FloatingActionButton(
                  backgroundColor: AColors.primary,
                  onPressed: () => Get.to(() => ChatbotScreen()),
                  child: Icon(Iconsax.message, color: Colors.white),
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
                    screenSize.height,
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
