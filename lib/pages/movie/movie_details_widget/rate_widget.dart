import 'package:flutter/material.dart';

class RateButtonWidget extends StatelessWidget {
  final VoidCallback? onTap;

  const RateButtonWidget({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.star,
            size: 30,
            color: Colors.amber, // Yellow star icon
          ),
          const SizedBox(width: 5),
          Text(
            'Rate This!',
            style: TextStyle(
              fontSize: 14,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w500,
              color: Theme.of(context).textTheme.bodyMedium?.color,
            ),
          ),
        ],
      ),
    );
  }
}
