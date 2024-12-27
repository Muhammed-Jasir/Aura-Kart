import 'dart:async';

import 'package:aurakart/common/widgets/success_screen/success_screen.dart';
import 'package:aurakart/data/repositories/authentication/authentication_repository.dart';
import 'package:aurakart/utils/constants/image_strings.dart';
import 'package:aurakart/utils/constants/text_strings.dart';
import 'package:aurakart/utils/popups/loaders.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerifyEmailController extends GetxController {
  static VerifyEmailController get instance => Get.find();

  /// Send email Whenever Verify Screen appears & Set Timer for auto redirect.
  @override
  void OnInit() {
    sendEmailVerification();
    setTimerForAutoRedirect();
    super.onInit();
  }

  /// Send Email Verification Link
  sendEmailVerification() async {
    try {
      await AuthenticationRepository.instance.sendEmailVerification();
      ALoaders.successSnackBar(
          title: 'Email Sent',
          message: 'Please Check your inbox and Verify Your Email.');
    } catch (e) {
      ALoaders.errorSnackBar(title: 'oh shap!', message: e.toString());
    }
  }

  /// Timer to Automatically redirect on Email verification

  setTimerForAutoRedirect() {
    Timer.periodic(const Duration(seconds: 1), (Timer) async {
      await FirebaseAuth.instance.currentUser?.reload();
      final user = FirebaseAuth.instance.currentUser;
      if (user?.emailVerified ?? false) {
        Timer.cancel();
        Get.off(() => SuccessScreen(
              image: AImages.successfullyRegisterAnimation,
              title: ATexts.yourAccountCreatedTitle,
              subTitle: ATexts.yourAccountCreatedSubTitle,
              onPressed: () =>
                  AuthenticationRepository.instance.screenRedirect(),
            ));
      }
    });
  }

  /// Manually check if Email verified
  checkEmailVerificationStatus() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null && currentUser.emailVerified) {
      Get.off(
        () => SuccessScreen(
          image: AImages.successfullyRegisterAnimation,
          title: ATexts.yourAccountCreatedTitle,
          subTitle: ATexts.yourAccountCreatedSubTitle,
          onPressed: () => AuthenticationRepository.instance.screenRedirect(),
        ),
      );
    }
  }
}
