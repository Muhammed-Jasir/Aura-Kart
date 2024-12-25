import 'package:aurakart/data/repositories/authentication/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:aurakart/app.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

// Entry Point of Flutter App
Future<void> main() async {
  // Add Widgets Binding
  final WidgetsBinding widgetsBinding =
      WidgetsFlutterBinding.ensureInitialized();

  // Getx Local Storage
  await GetStorage.init();

  // Await Splash until other items Load
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // Initialize Firebase & Authentication Repository
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then(
    (FirebaseApp value) => Get.put(AuthenticationRepository()),
  );

  runApp(const MyApp());
}
