import 'package:aurakart/features/authentication/controllers/signup/signup_controller.dart';
import 'package:aurakart/utils/constants/colors.dart';
import 'package:aurakart/utils/constants/sizes.dart';
import 'package:aurakart/utils/constants/text_strings.dart';
import 'package:aurakart/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ATermsConditonCheckbox extends StatelessWidget {
  const ATermsConditonCheckbox({super.key});

  @override
  Widget build(BuildContext context) {
    
    final controller = SignupController.instance;
    final darkMode = AHelperFunctions.isDarkMode(context);

    return Row(
      children: [
        /// Checkbox
        SizedBox(
          width: 24,
          height: 24,
          child: Obx(
            () => Checkbox(
              value: controller.privacyPolicy.value , 
          onChanged: (value) => controller.privacyPolicy.value = !controller.privacyPolicy.value),
          ),
        ),

        const SizedBox(width: ASizes.spaceBtwItems),

        // Text
        Expanded(
          child: Text.rich(
            TextSpan(
              children: [
                // Agree Text
                TextSpan(
                  text: '${ATexts.isAgreeTo} ',
                  style: Theme.of(context).textTheme.bodySmall,
                ),

                // Privacy Policy Text
                TextSpan(
                  text: ATexts.privacyPolicy,
                  style: Theme.of(context).textTheme.bodyMedium!.apply(
                        color: darkMode ? AColors.white : AColors.primary,
                        decoration: TextDecoration.underline,
                        decorationColor:
                            darkMode ? AColors.white : AColors.primary,
                      ),
                ),

                // And Text
                TextSpan(
                  text: ' ${ATexts.and} ',
                  style: Theme.of(context).textTheme.bodySmall,
                ),

                // Terms Text
                TextSpan(
                  text: ATexts.termsOfUse,
                  style: Theme.of(context).textTheme.bodyMedium!.apply(
                      color: darkMode ? AColors.white : AColors.primary,
                      decoration: TextDecoration.underline,
                      decorationColor:
                          darkMode ? AColors.white : AColors.primary),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
