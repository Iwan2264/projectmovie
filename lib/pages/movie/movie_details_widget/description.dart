import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projectmovie/models/movie.dart';
import 'package:projectmovie/controllers/movie_controllers/movie_controller.dart';

class MoviePosterDescription extends StatelessWidget {
  final Movie movie;
  final double width;

  const MoviePosterDescription({
    super.key,
    required this.movie,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MovieController>();
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Poster and Description
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Poster
                movie.posterPath.isNotEmpty
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                          width: width * 0.3,
                          height: 180,
                          fit: BoxFit.cover,
                        ),
                      )
                    : Container(
                        width: width * 0.3,
                        height: 180,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: colorScheme.surfaceContainerHighest,
                        ),
                        child: Center(
                          child: Text(
                            "Poster",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                      ),
                // Description
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 5, 5, 5),
                  child: SizedBox(
                    width: width * 0.7 - 31,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          movie.overview,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: colorScheme.onSurface,
                              ),
                          maxLines: 9,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          // Genres
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Center(
              child: Wrap(
                spacing: 10,
                children: movie.genreIds.take(5).map((id) {
                  final genre = controller.getGenreNameById(id);
                  return Chip(
                    backgroundColor: colorScheme.surfaceContainerHigh,
                    label: Text(
                      genre,
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}