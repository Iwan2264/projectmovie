import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projectmovie/controllers/settings_controllers/theme_controller.dart';

class AppearanceLanguagePage extends StatelessWidget {
  final ThemeController themeController = Get.find();

  AppearanceLanguagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Appearance & Language')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const Text(
              'Theme Mode',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Obx(() => Column(
                  children: [
                    RadioListTile<ThemeMode>(
                      title: const Text('System Default'),
                      value: ThemeMode.system,
                      groupValue: themeController.themeMode.value,
                      onChanged: (value) => themeController.setTheme(value!),
                    ),
                    RadioListTile<ThemeMode>(
                      title: const Text('Light Mode'),
                      value: ThemeMode.light,
                      groupValue: themeController.themeMode.value,
                      onChanged: (value) => themeController.setTheme(value!),
                    ),
                    RadioListTile<ThemeMode>(
                      title: const Text('Dark Mode'),
                      value: ThemeMode.dark,
                      groupValue: themeController.themeMode.value,
                      onChanged: (value) => themeController.setTheme(value!),
                    ),
                  ],
                )),
            const SizedBox(height: 32),
            const Text(
              'Language',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            // Replace with your language picker logic if available
            const Text('Language selection coming soon.'),
          ],
        ),
      ),
    );
  }
}