import 'package:aurakart/data/repositories/authentication/authentication_repository.dart';
import 'package:aurakart/data/repositories/user/user_repository.dart';
import 'package:aurakart/features/authentication/screens/signup/verify_email.dart';
import 'package:aurakart/features/personalization/models/user_model.dart';
import 'package:aurakart/utils/constants/image_strings.dart';
import 'package:aurakart/utils/helpers/network_manager.dart';
import 'package:aurakart/utils/popups/full_screen_loader.dart';
import 'package:aurakart/utils/popups/loaders.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  /// Variables
  final hidePassword = true.obs; // Observe for hiding/showing password
  final privacyPolicy = true.obs; // Observe for privacy policy acceptance
  final email = TextEditingController(); // Controller for email input
  final lastName = TextEditingController(); // Controller for lastname input
  final username = TextEditingController(); // Controller for username input
  final password = TextEditingController(); // Controller for password input
  final firstname = TextEditingController(); // Controller for firstname input
  final phoneNumber =
      TextEditingController(); // Controller for phone number input

  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

  /// Signup
  void signup() async {
    try {
      // Start Loading
      AFullScreenLoader.openLoadingDialog(
        'We Are Processing Your Information...',
        AImages.docerAnimation,
      );

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        // Remove Loader
        AFullScreenLoader.stopLoading();
        return;
      }

      // Form Validation
      if (!signupFormKey.currentState!.validate()) {
        // Remove Loader
        AFullScreenLoader.stopLoading();
        return;
      }

      // Privacy Policy Check
      if (!privacyPolicy.value) {
        ALoaders.warningSnackBar(
          title: 'Accept Privacy Policy',
          message:
              'In order to create account, you must have to accept the privacy policy & Terms & Conditions',
        );
        return;
      }

      // Register user in the Firebase Auth & save user data in the Firebase
      final userCredential = await AuthenticationRepository.instance
          .registerWithEmailAndPassword(
              email.text.trim(), password.text.trim());

      // Save Authenticated user data in the Firebase Firestore
      final newUser = UserModel(
        id: userCredential.user!.uid,
        firstName: firstname.text.trim(),
        lastName: lastName.text.trim(),
        username: username.text.trim(),
        email: email.text.trim(),
        phoneNumber: phoneNumber.text.trim(),
        profilePicture: '',
      );

      final userRepository = Get.put(UserRepository());
      await userRepository.saveUserRecord(newUser);

      // Remove Loader
      AFullScreenLoader.stopLoading();

      // Show Success Messege
      ALoaders.successSnackBar(
        title: 'Congratulations',
        message: 'Your account has been created! Verify email to continue.',
      );

      // Move to Verify Email Screen
      Get.to(() => VerifyEmailScreen(email: email.text.trim()));

    } catch (e) {
      // Remove Loader
      AFullScreenLoader.stopLoading();

      // Show some generic error to user
      ALoaders.errorSnackBar(title: 'Oh snapp!', message: e.toString());
    }
  }
}
