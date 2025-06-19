import 'package:flutter/material.dart';

class SubSettingsListWidget extends StatelessWidget {
  final List<String> settings;
  final void Function(String setting)? onTap;

  const SubSettingsListWidget({
    super.key,
    required this.settings,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: settings.map((setting) {
        return ListTile(
          title: Text(setting),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => onTap?.call(setting),
        );
      }).toList(),
    );
  }
}
