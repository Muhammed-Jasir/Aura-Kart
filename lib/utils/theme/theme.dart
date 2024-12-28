import 'package:aurakart/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:aurakart/utils/theme/widget_themes/appbar_theme.dart';
import 'package:aurakart/utils/theme/widget_themes/bottom_sheet_theme.dart';
import 'package:aurakart/utils/theme/widget_themes/checkbox_theme.dart';
import 'package:aurakart/utils/theme/widget_themes/chip_theme.dart';
import 'package:aurakart/utils/theme/widget_themes/eleveted_button_theme.dart';
import 'package:aurakart/utils/theme/widget_themes/outlined_button_theme.dart';
import 'package:aurakart/utils/theme/widget_themes/text_field_theme.dart';
import 'package:aurakart/utils/theme/widget_themes/text_theme.dart';

class AAppTheme {
  AAppTheme._(); // To avoid creating instances

  // Light Theme
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.light,
    primaryColor: AColors.primary,
    disabledColor: AColors.grey,
    scaffoldBackgroundColor: AColors.light,
    textTheme: ATextTheme.lightTextTheme,
    elevatedButtonTheme: AElevetedButtonTheme.lightElevetedButtonTheme,
    appBarTheme: AAppbarTheme.lightAppbarTheme,
    bottomSheetTheme: ABottomSheetTheme.lightBottomSheetTheme,
    checkboxTheme: ACheckboxTheme.lightCheckboxTheme,
    outlinedButtonTheme: AOutlinedButtonTheme.lightOutlineButtonTheme,
    chipTheme: AChipTheme.lightChipTheme,
    inputDecorationTheme: ATextFieldTheme.lightInputDecorationTheme,
  );

  // Dark Theme
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.dark,
    primaryColor: AColors.primary,
    disabledColor: AColors.grey,
    scaffoldBackgroundColor: AColors.dark,
    textTheme: ATextTheme.darkTextTheme,
    elevatedButtonTheme: AElevetedButtonTheme.darkElevetedButtonTheme,
    appBarTheme: AAppbarTheme.darkAppbarTheme,
    bottomSheetTheme: ABottomSheetTheme.darkBottomSheetTheme,
    checkboxTheme: ACheckboxTheme.darkCheckboxTheme,
    outlinedButtonTheme: AOutlinedButtonTheme.darkOutlineButtonTheme,
    chipTheme: AChipTheme.darkChipTheme,
    inputDecorationTheme: ATextFieldTheme.darkInputDecorationTheme,
  );
}
