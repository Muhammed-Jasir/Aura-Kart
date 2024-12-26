import 'package:aurakart/features/authentication/screens/login/login.dart';
import 'package:aurakart/features/authentication/screens/onboarding/onboarding.dart';
import 'package:aurakart/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:aurakart/utils/exceptions/firebase_exceptions.dart';
import 'package:aurakart/utils/exceptions/format_exceptions.dart';
import 'package:aurakart/utils/exceptions/platform_exceptions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  // Variables
  final deviceStorage = GetStorage();
  final _auth = FirebaseAuth.instance;

  // Called from main.dart on app launch
  @override
  void onReady() {
    FlutterNativeSplash.remove();
    screenRedirect();
  }

  // Function to Show Relevant Screen
  screenRedirect() async {
    // Local Storage
    if (kDebugMode) {
      print('================== GET STORAGE AUTH REPO =================');
      print(deviceStorage.read('IsFirstTime'));
    }

    deviceStorage.writeIfNull('IsFirstTime', true);

    deviceStorage.read('IsFirstTime') != true
        ? Get.offAll(() =>
            const LoginScreen()) //redirect to login screen if not the first name
        : Get.offAll(
            const OnBoardingScreen()); // redirect to oonboarding screen if its first time
  }
}

/// email authentication- signin
 

/// email authentication register
Future<UserCredential> registerWithEmailAndPassword(String email, String password) async {
 try{
   return await _auth.createUserWithEmailAndPassword(email: email, password: password);
 } on FirebaseAuthException catch (e) {
   throw AFirebaseAuthException(e.code).message;
 } on FirebaseException catch (e) {
   throw AFirebaseException(e.code).message;
 } on FormatException catch (_) {
   throw const AFormatException();
 } on PlatformException catch (e) {
   throw APlatformException(e.code).message;
 } catch (e) {
   throw 'Something went wrong. Please try again';
 }
}

