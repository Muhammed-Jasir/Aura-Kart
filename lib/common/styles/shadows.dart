import 'package:aurakart/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class AShadowStyle {
  static final verticalProductShadow = BoxShadow(
    color: AColors.darkGrey.withValues(alpha: 0.1),
    blurRadius: 50,
    spreadRadius: 7,
    offset: const Offset(0, 2),
  );

  static final horizontalProductShadow = BoxShadow(
    color: AColors.darkGrey.withValues(alpha: 0.1),
    blurRadius: 50,
    spreadRadius: 7,
    offset: const Offset(0, 2),
  );
}
