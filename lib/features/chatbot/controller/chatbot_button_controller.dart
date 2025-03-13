import 'dart:ui';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ChatbotButtonController extends GetxController {
  static ChatbotButtonController get instance => Get.find();

  RxBool isDragging = false.obs;
  RxBool isButtonVisible = true.obs;

  // Observable Offset for button position
  Rx<Offset> buttonPosition = Offset(280, 600).obs;

  // Update position and snap to edges
  void updatePosition(
    Offset newPosition,
    double screenWidth,
    double screenHeight,
  ) {
    double margin = 20;

    // Snap to left or right
    // when x position is less than screen width ? left => margin : right => screenwidth - 56 - margin
    // here 56 is the width of floating button
    double newX =
        newPosition.dx < screenWidth / 2 ? margin : screenWidth - 56 - margin;

    double newY = newPosition.dy.clamp(margin, screenHeight - 56 - margin);

    buttonPosition.value = Offset(newX, newY);
  }

  void hideButton() => isButtonVisible.value = false;
  void showButton() => isButtonVisible.value = true;
}
