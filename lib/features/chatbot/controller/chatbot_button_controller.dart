import 'dart:ui';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ChatbotButtonController extends GetxController {
  static ChatbotButtonController get instance => Get.find();

  RxBool isDragging = false.obs;
  RxBool isButtonVisible = true.obs;

  // Observable Offset for button position
  Rx<Offset> buttonPosition = const Offset(20, 100).obs;

  // Update position and snap to edges
  void updatePosition(Offset newPosition, double screenWidth) {
    if (isButtonVisible.value) {
      // Snap to the closest edge (left or right)
      double newX = newPosition.dx < screenWidth / 2 ? 0 : screenWidth - 56;
      // Keep the Y position as is
      buttonPosition.value = Offset(newX, newPosition.dy);
    }
  }

  void hideButton() {
    isButtonVisible.value = false;
  }

  void showButton() {
    isButtonVisible.value = true;
  }
}
