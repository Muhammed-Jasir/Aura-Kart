import 'package:aurakart/features/authentication/controllers/login/login_controller.dart';
import 'package:aurakart/utils/constants/colors.dart';
import 'package:aurakart/utils/constants/image_strings.dart';
import 'package:aurakart/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ASocialButtons extends StatelessWidget {
  const ASocialButtons({super.key});
  
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        /// Google Sign In Button
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: AColors.grey),
            borderRadius: BorderRadius.circular(100),
          ),
          child: IconButton(
            onPressed: () => controller.googleSignIn(),
            icon: const Image(
              width: ASizes.iconMd,
              height: ASizes.iconMd,
              image: AssetImage(AImages.google),
            ),
          ),
        ),

        const SizedBox(width: ASizes.spaceBtwItems),

        /// Facebook Sign In Button
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: AColors.grey),
            borderRadius: BorderRadius.circular(100),
          ),
          child: IconButton(
            onPressed: () {},
            icon: const Image(
              width: ASizes.iconMd,
              height: ASizes.iconMd,
              image: AssetImage(AImages.facebook),
            ),
          ),
        ),
      ],
    );
  }
}
