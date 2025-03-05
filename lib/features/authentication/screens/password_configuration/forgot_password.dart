import 'package:aurakart/common/widgets/appbar/appbar.dart';
import 'package:aurakart/features/authentication/controllers/forget_password/forget_password_controller.dart';
import 'package:aurakart/features/authentication/screens/password_configuration/reset_password.dart';
import 'package:aurakart/utils/constants/sizes.dart';
import 'package:aurakart/utils/constants/text_strings.dart';
import 'package:aurakart/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ForgetPasswordController());
    
    return Scaffold(
        // Appbar
        appBar: const AAppBar(),

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
              Form(
                key: controller.forgetPasswordFormKey,
                child: TextFormField(
                  controller: controller.email,
                  validator: AValidator.validateEmail,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Iconsax.direct_right),
                    labelText: ATexts.email,
                  ),
                ),
              ),

              const SizedBox(height: ASizes.spaceBtwSections),

              /// Submit Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => controller.sendPasswordResetEmail(),
                  child: const Text(ATexts.submit),
                ),
              ),
            ],
          ),
        ),
      ); 
  }
}
