import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projectmovie/controllers/settings_controllers/theme_controller.dart';

class AppearancePage extends StatelessWidget {
  final ThemeController themeController = Get.find();

  AppearancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Appearance')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Theme Mode',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),

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
      ),
    );
  }
}
