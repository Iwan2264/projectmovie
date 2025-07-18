import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projectmovie/controllers/movie_controllers/watchlist_controller.dart';
import 'package:projectmovie/models/movie.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:projectmovie/models/watchlist_entry.dart';

class RateButtonWidget extends StatelessWidget {
  final Movie movie;

  const RateButtonWidget({super.key, required this.movie});

  void _showRatingDialog(BuildContext context, WatchlistController watchlistController) {
    final double? currentScore = watchlistController.getScore(movie);
    double selectedScore = currentScore ?? 10.0;

    showDialog(
      context: context,
      builder: (_) {
        return StatefulBuilder(
          builder: (context, setState) => AlertDialog(
            titlePadding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            contentPadding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
            actionsPadding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Rate Movie", style: Theme.of(context).textTheme.titleLarge),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                  tooltip: "Close",
                ),
              ],
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Slider(
                  value: selectedScore,
                  min: 0,
                  max: 10,
                  divisions: 20,
                  label: selectedScore.toStringAsFixed(1),
                  onChanged: (val) => setState(() => selectedScore = val),
                ),
                Text(
                  "${selectedScore.toStringAsFixed(1)} / 10",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      watchlistController.setScore(movie, selectedScore);
                      final status = watchlistController.getStatus(movie);
                      if (status == null || status == WatchStatus.planToWatch) {
                        watchlistController.setStatus(movie, WatchStatus.watched);
                      }
                      Navigator.of(context).pop();
                    },
                    child: const Text("Save"),
                  ),
                  if (currentScore != null) ...[
                    const SizedBox(width: 16),
                    OutlinedButton(
                      onPressed: () {
                        watchlistController.setScore(movie, null);
                        Navigator.of(context).pop();
                      },
                      child: const Text("Remove Rating"),
                    ),
                  ],
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final watchlistController = Get.find<WatchlistController>();

    return Obx(() {
      final score = watchlistController.getScore(movie);

      if (score == null) {
        return InkWell(
          onTap: () => _showRatingDialog(context, watchlistController),
          borderRadius: BorderRadius.circular(12),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.star, size: 24, color: colorScheme.secondary),
              const SizedBox(width: 4),
              Text(
                "Rate This!",
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: colorScheme.onSurface,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        );
      }

      return InkWell(
        onTap: () => _showRatingDialog(context, watchlistController),
        borderRadius: BorderRadius.circular(12),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            RatingBarIndicator(
              rating: score / 2,
              itemBuilder: (context, index) => const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              itemCount: 5,
              itemSize: 22.0,
              unratedColor: colorScheme.outlineVariant.withAlpha((0.3 * 255).round()),
              direction: Axis.horizontal,
            ),
            const SizedBox(width: 4),
            Text(
              (score / 2).toStringAsFixed(1),
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurface,
                fontWeight: FontWeight.w600,
                fontSize: 12,
                fontFamily: 'Roboto',
              ),
            ),
          ],
        ),
      );
    });
  }
}