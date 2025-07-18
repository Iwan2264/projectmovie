import 'package:flutter/material.dart';

class WatchlistStats extends StatelessWidget {
  final int watched;
  final int planToWatch;
  final int rewatched;
  final int dropped;
  final int total;

  const WatchlistStats({
    Key? key,
    required this.watched,
    required this.planToWatch,
    required this.rewatched,
    required this.dropped,
    required this.total,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      color: colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 18),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _statItem('Watched', watched, colorScheme.primary),
            _statItem('Plan', planToWatch, colorScheme.secondary),
            _statItem('Rewatched', rewatched, colorScheme.tertiary),
            _statItem('Dropped', dropped, colorScheme.error),
            _statItem('Total', total, colorScheme.surfaceTint),
          ],
        ),
      ),
    );
  }

  Widget _statItem(String label, int count, Color color) {
    return Column(
      children: [
        Text(label, style: TextStyle(color: color, fontWeight: FontWeight.w600)),
        Text('$count', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      ],
    );
  }
}