import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projectmovie/models/movie.dart';
import 'package:projectmovie/pages/movie/movie_details_page.dart';

class EnhancedMovieCardWidget extends StatelessWidget {
  final Movie movie;

  const EnhancedMovieCardWidget({
    super.key,
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(() => MovieDetailsPage(movieId: movie.id)),
      child: Container(
        width: 140,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Movie Poster
            Expanded(
              flex: 3,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                      color: Theme.of(context).colorScheme.surfaceVariant,
                      image: movie.posterPath.isNotEmpty
                          ? DecorationImage(
                              image: NetworkImage('https://image.tmdb.org/t/p/w300${movie.posterPath}'),
                              fit: BoxFit.cover,
                            )
                          : null,
                    ),
                    child: movie.posterPath.isEmpty
                        ? Center(
                            child: Icon(
                              Icons.image_not_supported_outlined,
                              color: Theme.of(context).colorScheme.onSurfaceVariant,
                              size: 40,
                            ),
                          )
                        : null,
                  ),
                  // Rating badge
                  if (movie.voteAverage > 0)
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.star, color: Colors.amber, size: 12),
                            const SizedBox(width: 2),
                            Text(
                              movie.voteAverage.toStringAsFixed(1),
                              style: const TextStyle(color: Colors.white, fontSize: 11),
                            ),
                          ],
                        ),
                      ),
                    ),
                  // Bookmark button
                  Positioned(
                    top: 8,
                    left: 8,
                    child: GestureDetector(
                      onTap: () {
                        Get.snackbar('Watchlist', 'Added to watchlist!');
                      },
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Icon(Icons.bookmark_border, color: Colors.white, size: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Movie Info
            Expanded(
              flex: 1,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: const BorderRadius.vertical(bottom: Radius.circular(16)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie.title,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      movie.releaseDate.isNotEmpty ? movie.releaseDate.substring(0, 4) : 'TBA',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}