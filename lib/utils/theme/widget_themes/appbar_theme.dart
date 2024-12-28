import 'package:aurakart/utils/constants/colors.dart';
import 'package:aurakart/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class AAppbarTheme {
  AAppbarTheme._();

  // Light Theme For Appbar
  static const lightAppbarTheme = AppBarTheme(
    elevation: 0,
    centerTitle: false,
    scrolledUnderElevation: 0,
    backgroundColor: Colors.transparent,
    surfaceTintColor: Colors.transparent,
    iconTheme: IconThemeData(color: AColors.black, size: ASizes.iconMd),
    actionsIconTheme: IconThemeData(color: AColors.black, size: ASizes.iconMd),
    titleTextStyle: TextStyle(
      fontSize: 18.0,
      color: AColors.black,
      fontWeight: FontWeight.w600,
    ),
  );

  // Dark Theme For Appbar
  static const darkAppbarTheme = AppBarTheme(
    elevation: 0,
    centerTitle: false,
    scrolledUnderElevation: 0,
    backgroundColor: Colors.transparent,
    surfaceTintColor: Colors.transparent,
    iconTheme: IconThemeData(color: AColors.black, size: ASizes.iconMd),
    actionsIconTheme: IconThemeData(color: AColors.white, size: ASizes.iconMd),
    titleTextStyle: TextStyle(
      fontSize: 18.0,
      color: AColors.white,
      fontWeight: FontWeight.w600,
    ),
  );
}
