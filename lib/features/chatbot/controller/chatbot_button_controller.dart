import 'dart:ui';

import 'package:aurakart/utils/device/device_utility.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ChatbotButtonController extends GetxController {
  static ChatbotButtonController get instance => Get.find();

  RxBool isDragging = false.obs;
  RxBool isButtonVisible = true.obs;

  // Observable Offset for button position
  Rx<Offset> buttonPosition = Offset.zero.obs;

  @override
  void onInit() {
    super.onInit();
    final screenSize = Get.context!.mediaQuerySize;
    double initialX = screenSize.width - 70; 
    double initialY = screenSize.height - 160;

    buttonPosition.value = Offset(initialX, initialY);
  }

  // Update position and snap to edges
  void updatePosition(
    Offset newPosition,
    double screenWidth,
    double screenHeight,
  ) {
    double margin = 20;
    double bottomNavHeight = ADeviceUtils.getBottomNavigationBarHeight();

    // Snap to left or right
    // when x position is less than screen width ? left => margin : right => screenwidth - 56 - margin
    // here 56 is the width of floating button
    // Snap to left or right edge
    double newX = newPosition.dx < screenWidth / 2 ? margin : screenWidth - 56 - margin;

    double newY = newPosition.dy.clamp(margin, screenHeight - bottomNavHeight - 56 - margin);

    buttonPosition.value = Offset(newX, newY);
  }

  void hideButton() => isButtonVisible.value = false;
  void showButton() => isButtonVisible.value = true;
}
