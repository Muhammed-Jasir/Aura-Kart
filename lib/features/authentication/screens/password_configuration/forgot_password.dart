import 'package:aurakart/common/widgets/appbar/appbar.dart';
import 'package:aurakart/features/authentication/screens/password_configuration/reset_password.dart';
import 'package:aurakart/utils/constants/sizes.dart';
import 'package:aurakart/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // Appbar
        appBar: const AAppBar(
          showBackArrow: true,
        ),

        // Body
        body: Padding(
          padding: const EdgeInsets.all(ASizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Text(
                ATexts.forgetPasswordTitle,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
      
              const SizedBox(height: ASizes.spaceBtwItems),
      
              // Sub-Title
              Text(
                ATexts.forgetPasswordSubtitle,
                style: Theme.of(context).textTheme.labelMedium,
              ),
      
              const SizedBox(height: ASizes.spaceBtwSections * 1.5),
      
              /// Email Text Field
              TextFormField(
                decoration: const InputDecoration(
                  prefixIcon: Icon(Iconsax.direct_right),
                  labelText: ATexts.email,
                ),
              ),
      
              const SizedBox(height: ASizes.spaceBtwSections),
      
              /// Submit Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Get.off(() => const ResetPassword()),
                  child: const Text(ATexts.submit),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
