import 'package:aurakart/common/styles/spacing_styles.dart';
import 'package:aurakart/features/authentication/screens/login/login.dart';
import 'package:aurakart/utils/constants/image_strings.dart';
import 'package:aurakart/utils/constants/sizes.dart';
import 'package:aurakart/utils/constants/text_strings.dart';
import 'package:aurakart/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({
    super.key,
    required this.image,
    required this.title,
    required this.subTitle,
    required this.onPressed,
  });

  final String image, title, subTitle;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: ASpacingStyle.paddingwithAppBarHeight * 2,
            child: Column(
              children: [
                /// Image
                Lottie.asset(
                  image,
                  width: AHelperFunctions.screenWidth() * 0.6,
                ),

                const SizedBox(height: ASizes.spaceBtwSections),

                // Title
                Text(
                  title,
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: ASizes.spaceBtwItems),

                /// Sub-Title
                Text(
                  subTitle,
                  style: Theme.of(context).textTheme.labelMedium,
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: ASizes.spaceBtwSections),

                // Continue Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: onPressed,
                    child: const Text(ATexts.tContinue),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
