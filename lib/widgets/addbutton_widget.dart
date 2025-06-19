import 'package:flutter/material.dart';

class AddToWatchlistButton extends StatelessWidget {
  final VoidCallback onTap;
  final bool isInWatchlist;
  final bool isWatched;

  const AddToWatchlistButton({
    super.key,
    required this.onTap,
    required this.isInWatchlist,
    this.isWatched = false,
  });

  @override
  Widget build(BuildContext context) {
    String label;
    IconData icon;

    if (isWatched) {
      label = 'Watched';
      icon = Icons.visibility_rounded;
    } else if (isInWatchlist) {
      label = 'Added to List';
      icon = Icons.check;
    } else {
      label = 'Add to Watchlist';
      icon = Icons.add;
    }

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 20,
              color: Theme.of(context).iconTheme.color,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontFamily: 'Inter',
                color: Theme.of(context).textTheme.bodyMedium?.color,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
