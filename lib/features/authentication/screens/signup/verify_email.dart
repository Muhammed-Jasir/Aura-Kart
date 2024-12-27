import 'package:aurakart/common/widgets/appbar/appbar.dart';
import 'package:aurakart/common/widgets/success_screen/success_screen.dart';
import 'package:aurakart/data/repositories/authentication/authentication_repository.dart';
import 'package:aurakart/features/authentication/controllers/signup/verify_email_controller.dart';
import 'package:aurakart/features/authentication/screens/login/login.dart';
import 'package:aurakart/utils/constants/image_strings.dart';
import 'package:aurakart/utils/constants/sizes.dart';
import 'package:aurakart/utils/constants/text_strings.dart';
import 'package:aurakart/utils/helpers/helper_functions.dart';
import 'package:aurakart/utils/http/http_client.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({super.key, this.email});

  final String? email;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VerifyEmailController());
    return Scaffold(
      // Appbar
      appBar: AAppBar(
        showBackArrow: false,
        actions: [
          // To go back to Login Screen
          IconButton(
            onPressed: () =>
                Get.offAll(() => AuthenticationRepository.instance.logout()),
            icon: const Icon(CupertinoIcons.clear),
          ),
        ],
      ),

      // Body
      body: SingleChildScrollView(
        /// Padding to all sides
        child: Padding(
          padding: const EdgeInsets.all(ASizes.defaultSpace),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                /// Image
                Image(
                  image: const AssetImage(AImages.deleiveredEmailIllustration),
                  width: AHelperFunctions.screenWidth() * 0.6,
                ),

                const SizedBox(height: ASizes.spaceBtwSections),

                /// Title
                Text(
                  ATexts.confirmEmail,
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: ASizes.spaceBtwItems),

                /// Email
                Text(
                  email ?? '',
                  style: Theme.of(context).textTheme.labelLarge,
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: ASizes.spaceBtwItems),

                /// Sub-Title
                Text(
                  ATexts.confirmEmailSubTitle,
                  style: Theme.of(context).textTheme.labelMedium,
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: ASizes.spaceBtwSections),

                // Continue Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => controller.checkEmailVerificationStatus(),
                    child: const Text(ATexts.tContinue),
                  ),
                ),

                const SizedBox(height: ASizes.spaceBtwItems),

                // Resent Email Button
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () => controller.sendEmailVerification(),
                    style: TextButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 15),
                    ),
                    child: const Text(ATexts.resendEmail),
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
