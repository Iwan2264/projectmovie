import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projectmovie/controllers/settings_controllers/settings_controller.dart';
import 'package:projectmovie/pages/settings/widget/profile_widget.dart';
import 'package:projectmovie/pages/settings/widget/settings_subpages_widget.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage({Key? key}) : super(key: key);
  final SettingsController controller = Get.put(SettingsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
                child: Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.settings, color: Theme.of(context).colorScheme.primary),
                      const SizedBox(width: 8),
                      const Text(
                        'Settings',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 16),
                child: Obx(
                  () => Form(
                    key: controller.formKey,
                    child: Column(
                      children: [
                        ProfileInfoWidget(controller: controller),

                        const SizedBox(height: 24),
                        SubSettingsListWidget(
                          settings: controller.settings.toList(),
                          onTap: controller.navigateToSetting,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
