import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter/material.dart';

class ThemeController extends GetxController {
  static ThemeController get instance => Get.find();

  final _storage = GetStorage();
  static const _key = 'isDarkMode';

  final RxBool isDarkMode = false.obs;

  @override
  void onInit() {
    super.onInit();
    // Load persisted preference; if not set, fall back to system setting
    final stored = _storage.read<bool>(_key);
    if (stored != null) {
      isDarkMode.value = stored;
      Get.changeThemeMode(stored ? ThemeMode.dark : ThemeMode.light);
    }
  }

  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
    _storage.write(_key, isDarkMode.value);
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
  }
}
