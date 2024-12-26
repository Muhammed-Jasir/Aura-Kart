import 'package:aurakart/data/repositories/authentication/authentication_repository.dart';
import 'package:aurakart/features/authentication/controllers/signup/signup_controller.dart';
import 'package:aurakart/features/authentication/screens/signup/verify_email.dart';
import 'package:aurakart/features/authentication/screens/signup/widgets/terms_conditon_checkbox.dart';
import 'package:aurakart/utils/constants/colors.dart';
import 'package:aurakart/utils/constants/sizes.dart';
import 'package:aurakart/utils/constants/text_strings.dart';
import 'package:aurakart/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ASignupForm extends StatelessWidget {
  const ASignupForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());
    return Form(
      key: controller.signupFormKey,
      child: Column(
        children: [
          /// First & Last Name
          Row(
            children: [
              // First Name
              Expanded(
                child: TextFormField(
                  controller: controller.firstname,
                  validator: (value) =>
                      AValidator.validateEmptyText('First name', value),
                      expands: false,
                  decoration: const InputDecoration(
                    labelText: ATexts.firstName,
                    prefixIcon: Icon(Iconsax.user),
                  ),
                ),
              ),

              const SizedBox(width: ASizes.spaceBtwInputFields),

              // Last Name
              Expanded(
                child: TextFormField(
                  controller: controller.lastName,
                  validator: (value) =>
                      AValidator.validateEmptyText('Last name', value),
                  expands: false,
                  decoration: const InputDecoration(
                    labelText: ATexts.lastName,
                    prefixIcon: Icon(Iconsax.user),
                  ),
                ),
              )
            ],
          ),

          const SizedBox(height: ASizes.spaceBtwInputFields),

          /// Username
          TextFormField(
            validator: (value) =>
                      AValidator.validateEmptyText('username', value),
            controller: controller.username,
            expands: false,
            decoration: const InputDecoration(
              labelText: ATexts.username,
              prefixIcon: Icon(Iconsax.user_edit),
            ),
          ),

          const SizedBox(height: ASizes.spaceBtwInputFields),

          /// Email
          TextFormField(
            validator: (value) =>
                      AValidator.validateEmail(value),
            controller: controller.email,
            decoration: const InputDecoration(
              labelText: ATexts.email,
              prefixIcon: Icon(Iconsax.direct),
            ),
          ),

          const SizedBox(height: ASizes.spaceBtwInputFields),

          /// Phone Number
          TextFormField(
            validator: (value) =>
                      AValidator.validatePhoneNumber(value),
            controller: controller.phoneNumber,
            decoration: const InputDecoration(
              labelText: ATexts.phoneNo,
              prefixIcon: Icon(Iconsax.call),
            ),
          ),

          const SizedBox(height: ASizes.spaceBtwInputFields),

          /// Password
          Obx(
            () =>  TextFormField(
              validator: (value) =>
                        AValidator.validatePassword(value),
              controller: controller.password,
              obscureText: controller.hidePassword.value,
              decoration: InputDecoration(
                labelText: ATexts.password,
                prefixIcon: const Icon(Iconsax.password_check),
                suffixIcon: IconButton(
                  onPressed: () => controller.hidePassword.value = !controller.hidePassword.value,
                  icon: Icon(controller.hidePassword.value ? Iconsax.eye_slash :  Iconsax.eye), 
                ),
              ),
            ),
          ),

          const SizedBox(height: ASizes.spaceBtwSections),

          /// Terms and Conditions Checkbox
          const ATermsConditonCheckbox(),
          const SizedBox(height: ASizes.spaceBtwSections),

          /// Signup Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Get.to(() => const VerifyEmailScreen()),
              child: const Text(ATexts.createAccount),
            ),
          ),
        ],
      ),
    );
  }
}
