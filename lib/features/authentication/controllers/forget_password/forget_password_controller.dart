import 'package:aurakart/data/repositories/authentication/authentication_repository.dart';
import 'package:aurakart/features/authentication/screens/password_configuration/reset_password.dart';
import 'package:aurakart/utils/constants/image_strings.dart';
import 'package:aurakart/utils/helpers/network_manager.dart';
import 'package:aurakart/utils/popups/full_screen_loader.dart';
import 'package:aurakart/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgetPasswordController extends GetxController {
  static ForgetPasswordController get instance => Get.find();

  /// Variables
  final email = TextEditingController();

  GlobalKey<FormState> forgetPasswordFormKey = GlobalKey<FormState>();

  /// Send Reset Password Email
  sendPasswordResetEmail() async {
    try {
      /// Start Loader
      AFullScreenLoader.openLoadingDialog(
        'Processing Your Request',
        AImages.docerAnimation,
      );

      /// Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        AFullScreenLoader.stopLoading();
        return;
      }

      /// Form Validation
      if (!forgetPasswordFormKey.currentState!.validate()) {
        AFullScreenLoader.stopLoading();
        return;
      }

      /// Send Reset Password Email
      await AuthenticationRepository.instance
          .sendPasswordResetEmail(email.text.trim());

      /// Remove Loader
      AFullScreenLoader.stopLoading();

      /// Show Success Screen
      ALoaders.successSnackBar(
        title: 'Email Sent',
        message: 'Email Link has been sent to Reset your password.',
      );

      /// Redirect
      Get.to(() => ResetPasswordScreen(email: email.text.trim()));
    } catch (e) {
      /// Remove Loader
      AFullScreenLoader.stopLoading();
      ALoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  resendPasswordResetEmail(String email) async {
    try {
      /// Start Loader
      AFullScreenLoader.openLoadingDialog(
        'Processing Your Request',
        AImages.docerAnimation,
      );

      /// Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        AFullScreenLoader.stopLoading();
        return;
      }

      /// Send Reset Password Email
      await AuthenticationRepository.instance.sendPasswordResetEmail(email);

      /// Remove Loader
      AFullScreenLoader.stopLoading();

      /// Show Success Message
      ALoaders.successSnackBar(
        title: 'Email Sent',
        message: 'Email Link has been sent to Reset your password',
      );
    } catch (e) {
      /// Remove Loader
      AFullScreenLoader.stopLoading();
      ALoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}
