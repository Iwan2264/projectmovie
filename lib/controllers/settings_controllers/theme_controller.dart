import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends GetxController {
  final themeMode = ThemeMode.system.obs;

  @override
  void onInit() {
    super.onInit();
    loadTheme();
  }

  Future<void> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final modeIndex = prefs.getInt('themeMode') ?? ThemeMode.system.index;
    themeMode.value = ThemeMode.values[modeIndex];
    Get.changeThemeMode(themeMode.value);
  }

  Future<void> setTheme(ThemeMode mode) async {
    themeMode.value = mode;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('themeMode', mode.index);
    Get.changeThemeMode(mode);
  }
}
