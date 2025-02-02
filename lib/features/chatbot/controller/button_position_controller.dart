import 'dart:ui';

import 'package:aurakart/features/shop/controllers/product/product_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ButtonPositionController extends GetxController {
  // Observable Offset for button position
  Rx<Offset> buttonPosition = const Offset(20, 100).obs;
// Update position
  void updatePosition(Offset newPosition, double screenWidth) {
    // Snap to the closest edge (left or right)
    double newX = newPosition.dx < screenWidth / 2 ? 0 : screenWidth - 56;
    buttonPosition.value = Offset(newX, newPosition.dy);
  }
}
