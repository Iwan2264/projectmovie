import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projectmovie/controllers/settings_controllers/theme_controller.dart';

class AppearancePage extends StatelessWidget {
  final ThemeController themeController = Get.find();

  AppearancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Appearance'),
        centerTitle: true,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: () {
              themeController.resetToDefaults();
              Get.snackbar('Reset', 'Appearance settings reset to defaults');
            },
            child: const Text('Reset'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Theme.of(context).colorScheme.primary.withOpacity(0.1),
                    Theme.of(context).colorScheme.surface,
                  ],
                ),
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Icon(
                      Icons.palette_outlined,
                      size: 48,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Customize Your Experience',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Theme Mode Section
                  _buildSectionHeader(context, 'Theme Mode', Icons.brightness_6_outlined),
                  const SizedBox(height: 16),
                  
                  Obx(() => Column(
                    children: [
                      _buildThemeOption(
                        context,
                        title: 'System Default',
                        icon: Icons.smartphone_outlined,
                        value: ThemeMode.system,
                        groupValue: themeController.themeMode.value,
                        onChanged: (value) => themeController.setThemeImmediate(value!),
                      ),
                      const SizedBox(height: 12),
                      _buildThemeOption(
                        context,
                        title: 'Light Mode',
                        icon: Icons.light_mode_outlined,
                        value: ThemeMode.light,
                        groupValue: themeController.themeMode.value,
                        onChanged: (value) => themeController.setThemeImmediate(value!),
                      ),
                      const SizedBox(height: 12),
                      _buildThemeOption(
                        context,
                        title: 'Dark Mode',
                        icon: Icons.dark_mode_outlined,
                        value: ThemeMode.dark,
                        groupValue: themeController.themeMode.value,
                        onChanged: (value) => themeController.setThemeImmediate(value!),
                      ),
                    ],
                  )),

                  const SizedBox(height: 32),

                  // Color Scheme Section
                  _buildSectionHeader(context, 'Color Theme', Icons.color_lens_outlined),
                  const SizedBox(height: 16),
                  
                  Obx(() => Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: themeController.colorSchemes.entries.map((entry) {
                      final isSelected = themeController.selectedColorScheme.value == entry.key;
                      return GestureDetector(
                        onTap: () => themeController.setColorScheme(entry.key),
                        child: Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: entry.value,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: isSelected 
                                  ? Theme.of(context).colorScheme.primary
                                  : Colors.transparent,
                              width: 3,
                            ),
                          ),
                          child: isSelected
                              ? const Icon(Icons.check, color: Colors.white, size: 24)
                              : null,
                        ),
                      );
                    }).toList(),
                  )),

                  const SizedBox(height: 32),

                  // Font Size Section
                  _buildSectionHeader(context, 'Font Size', Icons.text_fields_outlined),
                  const SizedBox(height: 16),
                  
                  Obx(() => Column(
                    children: themeController.fontSizeMultipliers.entries.map((entry) {
                      final isSelected = themeController.fontSize.value == entry.key;
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: ListTile(
                          title: Text(
                            _getFontSizeDisplayName(entry.key),
                            style: TextStyle(
                              fontSize: 16 * entry.value,
                              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                            ),
                          ),
                          trailing: isSelected 
                              ? Icon(Icons.check, color: Theme.of(context).colorScheme.primary)
                              : null,
                          onTap: () => themeController.setFontSize(entry.key),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: BorderSide(
                              color: isSelected 
                                  ? Theme.of(context).colorScheme.primary
                                  : Theme.of(context).colorScheme.outline.withOpacity(0.2),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  )),

                  const SizedBox(height: 32),

                  // Accessibility Section
                  _buildSectionHeader(context, 'Accessibility', Icons.accessibility_outlined),
                  const SizedBox(height: 16),
                  
                  Obx(() => Column(
                    children: [
                      SwitchListTile(
                        title: const Text('High Contrast'),
                        subtitle: const Text('Improved visibility for better readability'),
                        value: themeController.isHighContrast.value,
                        onChanged: (_) => themeController.toggleHighContrast(),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: BorderSide(
                            color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      SwitchListTile(
                        title: const Text('Reduced Animations'),
                        subtitle: const Text('Minimize motion for better experience'),
                        value: themeController.reducedAnimations.value,
                        onChanged: (_) => themeController.toggleReducedAnimations(),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: BorderSide(
                            color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
                          ),
                        ),
                      ),
                    ],
                  )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: Theme.of(context).colorScheme.primary, size: 24),
        const SizedBox(width: 12),
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildThemeOption(
    BuildContext context, {
    required String title,
    required IconData icon,
    required ThemeMode value,
    required ThemeMode groupValue,
    required ValueChanged<ThemeMode?> onChanged,
  }) {
    final isSelected = value == groupValue;
    
    return Container(
      decoration: BoxDecoration(
        color: isSelected 
            ? Theme.of(context).colorScheme.primaryContainer.withOpacity(0.3)
            : Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isSelected 
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.outline.withOpacity(0.2),
          width: isSelected ? 2 : 1,
        ),
      ),
      child: RadioListTile<ThemeMode>(
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isSelected 
                    ? Theme.of(context).colorScheme.primary.withOpacity(0.1)
                    : Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.5),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                size: 20,
                color: isSelected 
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
              ),
            ),
            const SizedBox(width: 12),
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: isSelected ? Theme.of(context).colorScheme.primary : null,
              ),
            ),
          ],
        ),
        value: value,
        groupValue: groupValue,
        onChanged: onChanged,
        activeColor: Theme.of(context).colorScheme.primary,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
    );
  }

  String _getFontSizeDisplayName(String key) {
    switch (key) {
      case 'small':
        return 'Small';
      case 'medium':
        return 'Medium';
      case 'large':
        return 'Large';
      case 'extra_large':
        return 'Extra Large';
      default:
        return key;
    }
  }
}
