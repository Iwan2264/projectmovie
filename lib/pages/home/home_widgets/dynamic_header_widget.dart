import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projectmovie/controllers/settings_controllers/settings_controller.dart';

class DynamicHeaderWidget extends StatelessWidget {
  const DynamicHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsController = Get.find<SettingsController>();

    return Obx(() {
      final name = settingsController.name.value.trim();
      final profileImage = settingsController.profileImage.value;

      return Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.primary.withAlpha((0.1 * 255).toInt()),
              Theme.of(context).colorScheme.secondary.withAlpha((0.05 * 255).toInt()),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundColor: Theme.of(context).colorScheme.primary,
              backgroundImage: profileImage != null ? FileImage(profileImage) : null,
              child: profileImage == null
                  ? Text(
                      name.isNotEmpty ? name[0].toUpperCase() : '?',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    )
                  : null,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _getGreeting(),
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).colorScheme.onSurface.withAlpha((0.7 * 255).toInt()),
                        ),
                  ),
                  Text(
                    name.isNotEmpty ? '$name!' : 'User!',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.notifications_outlined),
              onPressed: () {
                Get.snackbar('Notifications', 'No new notifications');
              },
            ),
          ],
        ),
      );
    });
  }

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning';
    } else if (hour < 17) {
      return 'Good Afternoon';
    } else {
      return 'Good Evening';
    }
  }
}