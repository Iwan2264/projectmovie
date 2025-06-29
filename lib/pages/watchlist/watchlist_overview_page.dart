import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projectmovie/controllers/movie_controllers/watchlist_controller.dart';
import 'package:projectmovie/pages/movie/movie_details_page.dart';

class WatchlistOverviewPage extends StatelessWidget {
  const WatchlistOverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    final watchlistController = Get.find<WatchlistController>();
    final isDark = Get.isDarkMode;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Watchlist"),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 1,
      ),
      body: Obx(() {
        final movies = watchlistController.watchlist;
        if (movies.isEmpty) {
          // Modern empty state, inspired by your EmptyWatchlistWidget
          return Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.bookmark_add_outlined,
                      size: 80,
                      color: Theme.of(context).colorScheme.primary.withOpacity(0.6)),
                  const SizedBox(height: 16),
                  Text(
                    'No movies in your watchlist yet',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Start adding movies you want to watch!',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.6),
                        ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: () {
                      // Go to "Browse Movies" (typically tab 0)
                      Get.back(); // or navController.selectedIndex.value = 0;
                    },
                    icon: const Icon(Icons.explore_outlined, size: 20),
                    label: const Text('Browse Movies'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.1),
                      foregroundColor: Theme.of(context).colorScheme.primary,
                      elevation: 0,
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        // Populated state: show the list of movies
        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: movies.length,
          separatorBuilder: (_, __) => const SizedBox(height: 16),
          itemBuilder: (context, index) {
            final movie = movies[index];
            return GestureDetector(
              onTap: () => Get.to(() => MovieDetailsPage(movieId: movie.id)),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceVariant,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: isDark ? Colors.black45 : Colors.black12,
                      blurRadius: 6,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: movie.posterPath.isNotEmpty
                          ? Image.network(
                              'https://image.tmdb.org/t/p/w200${movie.posterPath}',
                              width: 80,
                              height: 110,
                              fit: BoxFit.cover,
                            )
                          : Container(
                              width: 80,
                              height: 110,
                              color: Colors.grey[400],
                              child: const Icon(Icons.image, size: 40),
                            ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            movie.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            movie.releaseDate,
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: Theme.of(context).hintColor,
                                ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        watchlistController.removeFromWatchlist(movie);
                      },
                      icon: const Icon(Icons.delete_outline),
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}