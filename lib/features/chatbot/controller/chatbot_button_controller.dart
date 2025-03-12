import 'dart:ui';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ChatbotButtonController extends GetxController {
  static ChatbotButtonController get instance => Get.find();

  RxBool isDragging = false.obs;
  RxBool isButtonVisible = true.obs;

  // Observable Offset for button position
  Rx<Offset> buttonPosition = const Offset(320, 600).obs;

  // Update position and snap to edges
  void updatePosition(
    Offset newPosition,
    double screenWidth,
    double screenHeight,
    double bottomNavHeight,
  ) {
    if (isButtonVisible.value) {
      double margin = 16;

      // Snap to left or right
      // when x position is less than screen width ? left => margin : right => screenwidth - 56 - margin
      // here 56 is the width of floating button
      double newX =
          newPosition.dx < screenWidth / 2 ? margin : screenWidth - 56 - margin;

      // Snap to top or bottom
      // when y position is less than screen height / 2 ? top => margin : bottom => screenwidth - bottomNavHeight - 56 - margin
      // here 56 is the width of floating button
      double newY = newPosition.dy < screenHeight / 2
          ? margin
          : screenHeight - bottomNavHeight - 56 - margin;

      buttonPosition.value = Offset(newX, newY);
    }
  }

  void hideButton() {
    isButtonVisible.value = false;
  }

  void showButton() {
    isButtonVisible.value = true;
  }
}
