import 'package:aurakart/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class AChipTheme {
  AChipTheme._();

  // Light Theme For Chip
  static ChipThemeData lightChipTheme = ChipThemeData(
    disabledColor: AColors.grey.withValues(alpha: 0.4),
    labelStyle: const TextStyle(color: AColors.black),
    selectedColor: AColors.primary,
    checkmarkColor: AColors.white,
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
  );

  // Dark Theme For Chip
  static ChipThemeData darkChipTheme = const ChipThemeData(
    disabledColor: AColors.darkerGrey,
    labelStyle: TextStyle(color: AColors.white),
    selectedColor: AColors.primary,
    checkmarkColor: AColors.white,
    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
  );
}
