import 'package:aurakart/features/authentication/controllers/onboading/onboarding_controller.dart';
import 'package:aurakart/utils/constants/colors.dart';
import 'package:aurakart/utils/constants/sizes.dart';
import 'package:aurakart/utils/device/device_utility.dart';
import 'package:aurakart/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class OnBoardingSkip extends StatelessWidget {
  const OnBoardingSkip({super.key});

  @override
  Widget build(BuildContext context) {
    final darkMode = AHelperFunctions.isDarkMode(context);
    
    return Positioned(
      top: ADeviceUtils.getAppBarHeight(),
      right: ASizes.defaultSpace,
      child: TextButton(
        onPressed: () => OnBoardingController.instance.skipPage(),
        style: TextButton.styleFrom(
          foregroundColor: darkMode ? AColors.light : AColors.dark,
          backgroundColor: darkMode
              ? AColors.primary.withOpacity(0.2)
              : AColors.primary.withOpacity(0.2),
          textStyle: const TextStyle(fontSize: 16),
        ),
        child: const Text('Skip'),
      ),
    );
  }
}
