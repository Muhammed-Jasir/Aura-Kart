import 'package:flutter/material.dart';
import 'package:aurakart/utils/constants/colors.dart';
import 'package:aurakart/utils/constants/sizes.dart';

class AOutlinedButtonTheme {
  AOutlinedButtonTheme._();

  // Light Theme For Outline Button
  static final lightOutlineButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      elevation: 0,
      foregroundColor: AColors.dark,
      side: const BorderSide(color: AColors.borderPrimary),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      textStyle: const TextStyle(
        fontSize: 16.0,
        color: AColors.black,
        fontWeight: FontWeight.w600,
      ),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ASizes.buttonRadius)),
    ),
  );

  // Dark Theme For Outline Button
  static final darkOutlineButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      elevation: 0,
      foregroundColor: AColors.light,
      side: const BorderSide(color: AColors.borderPrimary),
      padding: const EdgeInsets.symmetric(
          vertical: ASizes.buttonHeight, horizontal: 20),
      textStyle: const TextStyle(
        fontSize: 16.0,
        color: AColors.textWhite,
        fontWeight: FontWeight.w600,
      ),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ASizes.buttonRadius)),
    ),
  );
}
