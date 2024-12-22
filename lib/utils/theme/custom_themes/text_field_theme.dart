import 'package:flutter/material.dart';
import 'package:aurakart/utils/constants/colors.dart';
import 'package:aurakart/utils/constants/sizes.dart';

class ATextFieldTheme {
  ATextFieldTheme._();

  // Light Theme For TextField
  static InputDecorationTheme lightInputDecorationTheme = InputDecorationTheme(
    errorMaxLines: 2,
    prefixIconColor: AColors.darkGrey,
    suffixIconColor: AColors.darkGrey,
    // consAraints: const BoxConstraints.expand(height: TSizes.inputFieldHeight),
    labelStyle: const TextStyle()
        .copyWith(fontSize: ASizes.fontSizeMd, color: AColors.darkGrey),
    hintStyle: const TextStyle(color: AColors.grey)
        .copyWith(fontSize: ASizes.fontSizeSm, color: AColors.darkGrey),
    errorStyle: const TextStyle().copyWith(fontStyle: FontStyle.normal),
    floatingLabelStyle: const TextStyle().copyWith(
      color: AColors.black.withOpacity(0.8),
    ),
    border: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(ASizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: AColors.grey),
    ),
    enabledBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(ASizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: AColors.grey),
    ),
    focusedBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(ASizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: AColors.dark),
    ),
    errorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(ASizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: AColors.warning),
    ),
    focusedErrorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(ASizes.inputFieldRadius),
      borderSide: const BorderSide(width: 2, color: AColors.warning),
    ),

    isDense: true,
    contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
  );

  // Dark Theme For Text Field
  static InputDecorationTheme darkInputDecorationTheme = InputDecorationTheme(
    errorMaxLines: 2,
    prefixIconColor: AColors.darkGrey,
    suffixIconColor: AColors.darkGrey,
    // constraints: const BoxConstraints.expand(height: TSizes.inputFieldHeight),
    labelStyle: const TextStyle()
        .copyWith(fontSize: ASizes.fontSizeMd, color: AColors.darkGrey),
    hintStyle: const TextStyle(color: AColors.grey)
        .copyWith(fontSize: ASizes.fontSizeSm, color: AColors.darkGrey),
    errorStyle: const TextStyle().copyWith(fontStyle: FontStyle.normal),
    floatingLabelStyle: const TextStyle().copyWith(
      color: AColors.white.withOpacity(0.8),
    ),
    border: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(ASizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: AColors.darkGrey),
    ),
    enabledBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(ASizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: AColors.darkGrey),
    ),
    focusedBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(ASizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: AColors.white),
    ),
    errorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(ASizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: AColors.warning),
    ),
    focusedErrorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(ASizes.inputFieldRadius),
      borderSide: const BorderSide(width: 2, color: AColors.warning),
    ),
    isDense: true,
    contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
  );
}
