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
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  ///variables
  final hidePassword = true.obs; //observe for hiding/showing password
  final privacyPolicy = true.obs; //observe for privacy policy acceptance
  final email = TextEditingController(); //controller for email input
  final lastName = TextEditingController(); //controller for lastname input
  final username = TextEditingController(); //controller for username input
  final password = TextEditingController(); //controller for password input
  final firstname = TextEditingController(); //controller for firstname input
  final phoneNumber =
      TextEditingController(); //controller for phone number input
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

  ///signup
  void signup() async {
    try {
      //start loading
      AFullScreenLoader.openLoadingDialog(
          'We Are Processing Your Information...', AImages.docerAnimation);

      // check internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) return;

      // form validation
      if (!signupFormKey.currentState!.validate()) return;

      //privacy policy check

      if (!privacyPolicy.value) {
        ALoaders.warningSnackBar(
          title: 'Accept Privacy Policy',
          message:
              'In order to create account, you must have to accept the privacy policy & Terms & Conditions',
        );
        return;
      }

      //register user in the firebase & save user data in the firebase

      final userCredential = await AuthenticationRepository.instance
          .registerWithEmailAndPassword(
              email.text.trim(), password.text.trim());

      // save authenticated user data in the firebase firestore
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

      // remove loader
      AFullScreenLoader.stopLoading();

      //show success messege
      ALoaders.successSnackBar(
          title: 'Congratulations',
          message: 'Your Account has been created ! verify email to continue');
      //move to verify email Screen
      Get.to(() => VerifyEmailScreen(
            email: email.text.trim(),
          ));
    } catch (e) {
      // remove loader
      AFullScreenLoader.stopLoading();

      // show some generic error to user
      ALoaders.errorSnackBar(title: 'Uh Oh MyNigga!', message: e.toString());
    }
  }
}
