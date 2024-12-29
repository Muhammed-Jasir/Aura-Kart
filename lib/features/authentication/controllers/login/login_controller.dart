import 'package:aurakart/data/repositories/authentication/authentication_repository.dart';
import 'package:aurakart/features/personalization/controllers/user_controller.dart';
import 'package:aurakart/utils/constants/image_strings.dart';
import 'package:aurakart/utils/helpers/network_manager.dart';
import 'package:aurakart/utils/popups/full_screen_loader.dart';
import 'package:aurakart/utils/popups/loaders.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginController extends GetxController {
  /// Variables
  final rememberMe = false.obs;

  final hidePassword = true.obs;
  final localStorage = GetStorage();
  final email = TextEditingController();
  final password = TextEditingController();

  GlobalKey<FormState> loginFormkey = GlobalKey<FormState>();
  final userController = Get.put(UserController());

  @override
  void onInit() {
    email.text = localStorage.read('REMEMBER_ME_EMAIL') ?? '';
    password.text = localStorage.read('REMEMBER_ME_PASSWORD') ?? '';
    super.onInit();
  }

  /// Email and Password Signin
  Future<void> emailAndPasswordSignIn() async {
    try {
      // Start Loading
      AFullScreenLoader.openLoadingDialog(
        'Logging you in...',
        AImages.docerAnimation,
      );

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        AFullScreenLoader.stopLoading();
        return;
      }

      // Form Validation
      if (!loginFormkey.currentState!.validate()) {
        AFullScreenLoader.stopLoading();
        return;
      }

      // Save Data if Remember Me is selected
      if (rememberMe.value) {
        localStorage.write('REMEMBER_ME_EMAIL', email.text.trim());
        localStorage.write('REMEMBER_ME_PASSWORD', password.text.trim());
      }

      // Login user using Email & Password Authentication
      // ignore: unused_local_variable
      final userCredentials = await AuthenticationRepository.instance
          .loginWithEmailAndPassword(email.text.trim(), password.text.trim());

      // Remove Loader
      AFullScreenLoader.stopLoading();

      // Redirect
      AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      AFullScreenLoader.stopLoading();
      ALoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }

  /// Google Sign In Authentication
  Future<void> googleSignIn() async {
    try {
      // Start Loading
      AFullScreenLoader.openLoadingDialog(
        'Logging you in...',
        AImages.docerAnimation,
      );

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        AFullScreenLoader.stopLoading();
        return;
      }

      // Google authentication
      final userCredential =
          await AuthenticationRepository.instance.signInWithGoogle();

      // Save User Record
      await userController.saveUserRecord(userCredential);

      //Remove Loader
      AFullScreenLoader.stopLoading();

      //Redirect
      AuthenticationRepository.instance.screenRedirect();
      
    } catch (e) {
      // Remove Loader
      AFullScreenLoader.stopLoading();
      
      ALoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }
}
