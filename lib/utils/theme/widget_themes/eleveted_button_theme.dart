import 'package:aurakart/utils/constants/colors.dart';
import 'package:aurakart/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class AElevetedButtonTheme {
  AElevetedButtonTheme._();

  // Light Theme For Eleveted Button
  static final lightElevetedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: AColors.light,
      backgroundColor: AColors.primary,
      disabledForegroundColor: AColors.darkGrey,
      disabledBackgroundColor: AColors.buttonDisabled,
      side: const BorderSide(color: AColors.primary),
      padding: const EdgeInsets.symmetric(vertical: ASizes.buttonHeight),
      textStyle: const TextStyle(
        fontSize: 16.0,
        color: AColors.textWhite,
        fontWeight: FontWeight.w600,
      ),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ASizes.buttonRadius)),
    ),
  );

  // Dark Theme For Eleveted Button
  static final darkElevetedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: AColors.light,
      backgroundColor: AColors.primary,
      disabledForegroundColor: AColors.darkGrey,
      disabledBackgroundColor: AColors.darkerGrey,
      side: const BorderSide(color: AColors.primary),
      padding: const EdgeInsets.symmetric(vertical: ASizes.buttonHeight),
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
