import 'package:aurakart/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class ABottomSheetTheme {
  ABottomSheetTheme._();

  // Light Theme For Bottom Sheet
  static BottomSheetThemeData lightBottomSheetTheme = BottomSheetThemeData(
    showDragHandle: true,
    backgroundColor: AColors.white,
    modalBackgroundColor: AColors.white,
    constraints: const BoxConstraints(minWidth: double.infinity),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
  );

  // Dark Theme For Bottom Sheet
  static BottomSheetThemeData darkBottomSheetTheme = BottomSheetThemeData(
    showDragHandle: true,
    backgroundColor: AColors.black,
    modalBackgroundColor: AColors.black,
    constraints: const BoxConstraints(minWidth: double.infinity),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
  );
}
