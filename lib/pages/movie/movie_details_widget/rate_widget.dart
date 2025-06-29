import 'package:flutter/material.dart';

class RateButtonWidget extends StatelessWidget {
  final VoidCallback? onTap;

  const RateButtonWidget({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.star,
            size: 30,
            color: colorScheme.secondary, // Material 3 secondary color
          ),
          const SizedBox(width: 5),
          Text(
            'Rate This!',
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: colorScheme.onSurface,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ],
      ),
    );
  }
}