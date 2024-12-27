import 'package:aurakart/features/authentication/controllers/login/login_controller.dart';
import 'package:aurakart/features/authentication/screens/password_configuration/forgot_password.dart';
import 'package:aurakart/features/authentication/screens/signup/signup.dart';
import 'package:aurakart/navigation_menu.dart';
import 'package:aurakart/utils/constants/colors.dart';
import 'package:aurakart/utils/constants/sizes.dart';
import 'package:aurakart/utils/constants/text_strings.dart';
import 'package:aurakart/utils/helpers/helper_functions.dart';
import 'package:aurakart/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ALoginForm extends StatelessWidget {
  const ALoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    final darkMode = AHelperFunctions.isDarkMode(context);

    return Form(
      key: controller.loginFormkey,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: ASizes.spaceBtwSections),
        child: Column(
          children: [
            /// Email
            TextFormField(
              controller: controller.email,
              validator: (value) => AValidator.validateEmail(value),
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.email_outlined),
                labelText: ATexts.email,
              ),
            ),

            const SizedBox(height: ASizes.spaceBtwInputFields),
            Obx(
              () => TextFormField(
                validator: (value) => AValidator.validatePassword(value),
                controller: controller.password,
                obscureText: controller.hidePassword.value,
                decoration: InputDecoration(
                  labelText: ATexts.password,
                  prefixIcon: const Icon(Iconsax.password_check),
                  suffixIcon: IconButton(
                    onPressed: () => controller.hidePassword.value =
                        !controller.hidePassword.value,
                    icon: Icon(controller.hidePassword.value
                        ? Iconsax.eye_slash
                        : Iconsax.eye),
                  ),
                ),
              ),
            ),
            const SizedBox(height: ASizes.spaceBtwInputFields / 2),

            /// Remembear Me & Forget Password
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /// Remembear Me
                Row(
                  children: [
                    Obx(() => Checkbox(
                        value: controller.rememberMe.value,
                        onChanged: (value) => controller.rememberMe.value =
                            !controller.rememberMe.value)),
                    const Text(ATexts.rememberMe),
                  ],
                ),

                // Forget Password
                TextButton(
                  onPressed: () => Get.to(() => const ForgetPassword()),
                  style: TextButton.styleFrom(
                    foregroundColor:
                        darkMode ? AColors.textSecondary : AColors.textPrimary,
                  ),
                  child: const Text(ATexts.forgetPassword),
                ),
              ],
            ),

            const SizedBox(height: ASizes.spaceBtwSections),

            /// Sign In Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => controller.emailAndPasswordSignIn(),
                child: const Text(ATexts.signIn),
              ),
            ),

            const SizedBox(height: ASizes.spaceBtwItems),

            /// Create Account Button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => Get.to(() => const SignupScreen()),
                child: const Text(ATexts.createAccount),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
