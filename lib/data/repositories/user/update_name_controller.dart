import 'package:aurakart/data/repositories/user/user_repository.dart';
import 'package:aurakart/features/personalization/controllers/user_controller.dart';
import 'package:aurakart/features/personalization/screens/profile/profile.dart';
import 'package:aurakart/utils/constants/image_strings.dart';
import 'package:aurakart/utils/helpers/network_manager.dart';
import 'package:aurakart/utils/popups/full_screen_loader.dart';
import 'package:aurakart/utils/popups/loaders.dart';
import 'package:flutter/material.dart';  
import 'package:get/get.dart';

/// Controller to manage user-related functionality.
class UpdateNameController extends GetxController {
  static UpdateNameController get instance => Get.find();

  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final userController = UserController.instance;
  final userRepository = Get.put(UserRepository());
  GlobalKey<FormState> updateUserNameFormkey = GlobalKey<FormState>();

  /// init user doto when Home Screen appears
  @override
  void onInit() {
    initializeNames();
    super.onInit();
  }

  /// Fetch user record
  Future<void> initializeNames() async {
    firstName.text = userController.user.value.firstName;
    lastName.text = userController.user.value.lastName;
  }

  Future<void> updateUserName() async {
    try {
  // Start Loading
      AFullScreenLoader.openLoadingDialog(
          'We are updating your information....', AImages.docerAnimation);

  // Check Internet Connectivity

      final isConnected = await NetworkManager.instance.isConnected();

      if (!isConnected) {
        AFullScreenLoader.stopLoading();
        return;
      }

  // Form Validation
      if (!updateUserNameFormkey.currentState!.validate()) {
        AFullScreenLoader.stopLoading();
        return;
      }

  // Update user's first & last name in the Firebase Firestore
      Map<String, dynamic> name = {
        'FirstName': firstName.text.trim(),
        'LastName': lastName.text.trim()
      };
      await userRepository.updateSingleField(name);

// Update the Rx User value
      userController.user.value.firstName = firstName.text.trim();
      userController.user.value.lastName = lastName.text.trim();

// Remove Loader
      AFullScreenLoader.stopLoading();

// Show Success Message
      ALoaders.successSnackBar(
          title: 'Congratulations', message: 'Your Name has been updated.');

// Move to previous screen.
      Get.off(() => const ProfileScreen());
    } catch (e) {
      AFullScreenLoader.stopLoading();
      ALoaders.errorSnackBar(title: "Uh OH !!", message: e.toString());
    }
  }
}
