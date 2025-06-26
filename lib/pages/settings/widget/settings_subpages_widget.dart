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
    if (settings.isEmpty) {
      return const Center(
        child: Text('No settings available.'),
      );
    }
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: settings.length,
      separatorBuilder: (context, index) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final setting = settings[index];
        return ListTile(
          title: Text(setting),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => onTap?.call(setting),
        );
      },
    );
  }
}
