import 'package:aurakart/utils/constants/colors.dart';
import 'package:aurakart/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ALoaders {
  static void _showSnackbar({
    required String title,
    required String message,
    required Color backgroundColor,
    required IconData icon,
    int duration = 3,
  }) {
    void show({int retriesLeft = 5}) {
      final context = Get.overlayContext;
      if (context == null || Overlay.maybeOf(context) == null) {
        if (retriesLeft > 0) {
          Future.delayed(
            const Duration(milliseconds: 200),
            () => show(retriesLeft: retriesLeft - 1),
          );
        }
        return;
      }

      try {
        Get.snackbar(
          title,
          message,
          isDismissible: true,
          shouldIconPulse: true,
          colorText: Colors.white,
          backgroundColor: backgroundColor,
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: duration),
          margin: const EdgeInsets.all(20),
          icon: Icon(icon, color: AColors.white),
        );
      } catch (_) {
        if (retriesLeft > 0) {
          Future.delayed(
            const Duration(milliseconds: 200),
            () => show(retriesLeft: retriesLeft - 1),
          );
        }
      }
    }

    WidgetsBinding.instance.addPostFrameCallback((_) => show());
  }

  static hideSnackBar() =>
      ScaffoldMessenger.of(Get.context!).hideCurrentSnackBar();

  static customToast({required message}) {
    ScaffoldMessenger.of(Get.context!).showSnackBar(
      SnackBar(
        elevation: 0,
        duration: const Duration(seconds: 3),
        backgroundColor: Colors.transparent,
        content: Container(
          padding: const EdgeInsets.all(12.0),
          margin: const EdgeInsets.symmetric(horizontal: 30),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: AHelperFunctions.isDarkMode(Get.context!)
                ? AColors.darkerGrey.withValues(alpha: 0.9)
                : AColors.grey.withValues(alpha: 0.9),
          ),
          child: Center(
            child: Text(
              message,
              style: Theme.of(Get.context!).textTheme.labelLarge,
            ),
          ),
        ),
      ),
    );
  }

  static successSnackBar({required title, message = '', duration = 3}) {
    _showSnackbar(
      title: title,
      message: message,
      backgroundColor: AColors.primary,
      icon: Iconsax.check,
      duration: duration,
    );
  }

  static warningSnackBar({required title, message = ''}) {
    _showSnackbar(
      title: title,
      message: message,
      backgroundColor: Colors.orange,
      icon: Iconsax.warning_2,
    );
  }

  static errorSnackBar({required title, message = ''}) {
    _showSnackbar(
      title: title,
      message: message,
      backgroundColor: Colors.red.shade600,
      icon: Iconsax.warning_2,
    );
  }
}
