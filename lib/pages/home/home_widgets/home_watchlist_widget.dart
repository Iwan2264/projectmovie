import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projectmovie/controllers/movie_controllers/watchlist_controller.dart';
import 'package:projectmovie/pages/watchlist/widgets/watchlist_stats.dart';
import 'package:projectmovie/pages/watchlist/watchlist_page.dart';
import 'package:projectmovie/pages/movie/movie_list_page.dart';

class HomeWatchlistWidget extends StatelessWidget {
  const HomeWatchlistWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final watchlistController = Get.find<WatchlistController>();
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                'Your Watchlist',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            TextButton(
              onPressed: () => Get.to(() => WatchlistPage()),
              style: TextButton.styleFrom(
                foregroundColor: colorScheme.primary,
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('See All'),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Obx(() {
          final watchlist = watchlistController.watchlist;
          if (watchlist.isEmpty) {
            // Empty state
            return Center(
              child: Container(
                width: screenWidth * 0.98,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: colorScheme.surfaceContainerHighest.withAlpha((0.3 * 255).toInt()),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: colorScheme.outline.withAlpha((0.2 * 255).toInt()),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: isDark ? Colors.black45 : Colors.black12,
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.bookmark_add_outlined,
                      size: 48,
                      color: colorScheme.primary.withAlpha((0.6 * 255).toInt()),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'No movies in your watchlist yet',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Start adding movies you want to watch!',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: colorScheme.primary.withAlpha((0.6 * 255).toInt()),
                          ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton.icon(
                      onPressed: () {
                        Get.to(() => MovieListPage());
                      },
                      icon: const Icon(Icons.explore_outlined, size: 18),
                      label: const Text('Browse Movies'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colorScheme.primary.withAlpha((0.1 * 255).toInt()),
                        foregroundColor: colorScheme.primary,
                        elevation: 0,
                        textStyle: Theme.of(context).textTheme.labelLarge,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          // Non-empty: show stats + preview (NO POSTERS)
          return Column(
            children: [
              WatchlistStats(
                watched: watchlistController.watched,
                planToWatch: watchlistController.planToWatch,
                rewatched: watchlistController.rewatched,
                dropped: watchlistController.dropped,
                total: watchlistController.total,
              ),
            ],
          );
        }),
      ],
    );
  }
}