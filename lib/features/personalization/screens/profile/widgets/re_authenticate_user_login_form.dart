import 'package:aurakart/features/personalization/controllers/user_controller.dart';
import 'package:aurakart/utils/constants/sizes.dart';
import 'package:aurakart/utils/constants/text_strings.dart';
import 'package:aurakart/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ReAuthLoginForm extends StatelessWidget {
  const ReAuthLoginForm({Key? Key}) :  super(key: Key);

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Scaffold(
      appBar: AppBar(title: const Text('Re-Authenticate User')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(ASizes.defaultSpace),
          child: Form(
            key: controller.reAuthFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                /// email
                TextFormField(
                  controller: controller.verifyEmail,
                  validator: AValidator.validateEmail,
                  decoration: const InputDecoration(prefixIcon: Icon(Iconsax.direct_right), labelText: ATexts.email),
                ),

                const SizedBox(height: ASizes.spaceBtwInputFields),

                /// password
                Obx(
                  () => TextFormField(
                    obscureText: controller.hidePassword.value,
                    controller: controller.verifyPassword,
                    validator: (value) => AValidator.validateEmptyText('password', value),
                    decoration: InputDecoration(
                      labelText: ATexts.password,
                      prefixIcon: IconButton(
                        onPressed: () => controller.hidePassword.value = !controller.hidePassword.value,
                      icon: const Icon(Iconsax.eye_slash),
                      ),
                    ),
                  )
                ),
                const SizedBox(height: ASizes.spaceBtwSections),

                /// Login button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(onPressed: () => controller.reAuthenticateEmailAndPasswordUser(), child: const Text('Verify')),
                )
              ],
            ),
           ),          
        ),
      ),
    );
  }
}
