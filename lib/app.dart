import 'package:aurakart/features/authentication/screens/onboarding/onboarding.dart';
import 'package:aurakart/utils/constants/colors.dart';
import 'package:aurakart/utils/theme/theme.dart';
import 'package:aurakart/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: ATexts.appName,
      themeMode: ThemeMode.system,
      theme: AAppTheme.lightTheme,
      darkTheme: AAppTheme.darkTheme,
      home: const Scaffold(
        backgroundColor: AColors.primary,
        body: Center(
          child: CircularProgressIndicator(color: AColors.white),
        ),
      ),
    );
  }
}
