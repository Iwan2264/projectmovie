import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projectmovie/controllers/movie_controllers/watchlist_controller.dart';
import 'package:projectmovie/models/movie.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RateButtonWidget extends StatelessWidget {
  final Movie movie;

  const RateButtonWidget({super.key, required this.movie});

  void _showRatingDialog(BuildContext context, double? currentScore, WatchlistController watchlistController) {
    double selectedScore = currentScore ?? 10.0;
    showDialog(
      context: context,
      builder: (_) {
        return StatefulBuilder(
          builder: (context, setState) => AlertDialog(
            title: const Text("Rate Movie"),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (i) {
                double threshold = (i + 1) * 2.0;
                return IconButton(
                  icon: Icon(
                    selectedScore >= threshold
                        ? Icons.star
                        : (selectedScore >= threshold - 1
                            ? Icons.star_half
                            : Icons.star_border),
                    color: Theme.of(context).colorScheme.secondary,
                    size: 40,
                  ),
                  onPressed: () {
                    setState(() {
                      selectedScore = threshold;
                    });
                  },
                );
              }),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel"),
              ),
              ElevatedButton(
                onPressed: () {
                  watchlistController.setScore(movie, selectedScore);
                  Navigator.pop(context);
                },
                child: const Text("Save"),
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
    final score = watchlistController.getScore(movie);

    if (score == null) {
      // Not rated yet: show "Rate This!" button
      return InkWell(
        onTap: () => _showRatingDialog(context, score, watchlistController),
        borderRadius: BorderRadius.circular(12),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.star,
              size: 30,
              color: colorScheme.secondary,
            ),
            const SizedBox(width: 5),
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
    } else {
      // Already rated: show stars and score, still clickable for updating
      return InkWell(
        onTap: () => _showRatingDialog(context, score, watchlistController),
        borderRadius: BorderRadius.circular(12),
        child: Row(
          children: [
            RatingBarIndicator(
              rating: score / 2, // divide by 2 to get 5-star scale
              itemBuilder: (context, index) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              itemCount: 5,
              itemSize: 20.0,
              unratedColor: colorScheme.outlineVariant.withAlpha((0.3 * 255).round()),
              direction: Axis.horizontal,
            ),
            const SizedBox(width: 6),
            Text(
              (score / 2).toStringAsFixed(1), // Show 4.5 for score 9, etc.
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
    }
  }
}