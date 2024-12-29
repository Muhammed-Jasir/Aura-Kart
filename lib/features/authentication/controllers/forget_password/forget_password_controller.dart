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

  /// variables
  final email = TextEditingController();
  GlobalKey<FormState> forgetPasswordFormKey = GlobalKey<FormState>();

  /// send Reset password email
  sendPasswordResendEmail() async {
    try {
      ///start loading
      AFullScreenLoader.openLoadingDialog(
          'Processing Your Request', AImages.docerAnimation);

      /// check internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        AFullScreenLoader.stopLoading();
        return;
      }

      ///form validation
      if (!forgetPasswordFormKey.currentState!.validate()) {
        AFullScreenLoader.stopLoading();
        return;
      }

      /// send email & reset password
      await AuthenticationRepository.instance
          .sendPasswordResetEmail(email.text.trim());

      ///remove loader
      AFullScreenLoader.stopLoading();

      ///show success screen
      ALoaders.successSnackBar(
          title: 'Email Sent',
          message: 'Email List sent to Reset your password'.tr);

      ///redirect
      Get.to(() => ResetPasswordScreen(email: email.text.trim()));
    } catch (e) {
      ///remove loader
      AFullScreenLoader.stopLoading();
      ALoaders.errorSnackBar
      (title: 'Uh OH', message: e.toString());
    }
  }




  resendPasswordResendEmail(String email) async {
    try {
      ///start loading
      AFullScreenLoader.openLoadingDialog(
          'Processing Your Request', AImages.docerAnimation);

      /// check internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        AFullScreenLoader.stopLoading();
        return;
      }

      /// send email & reset password
      await AuthenticationRepository.instance
          .sendPasswordResetEmail(email);

      ///remove loader
      AFullScreenLoader.stopLoading();

      ///show success screen
      ALoaders.successSnackBar(
          title: 'Email Sent',
          message: 'Email List sent to Reset your password'.tr);
          
    } catch (e) {
      ///remove loader
      AFullScreenLoader.stopLoading();
      ALoaders.errorSnackBar
      (title: 'Uh OH', message: e.toString());
    }
  }
}
