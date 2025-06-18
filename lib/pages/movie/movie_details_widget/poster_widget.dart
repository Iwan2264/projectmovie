import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projectmovie/models/movie.dart';
import 'package:projectmovie/controllers/movie_controller.dart';

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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Poster and Description
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Poster
              movie.posterPath.isNotEmpty
                  ? Image.network(
                      'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                      width: width * 0.3,
                      height: 180,
                      fit: BoxFit.cover,
                    )
                  : Container(
                      width: width * 0.3,
                      height: 180,
                      color: Theme.of(context).colorScheme.surfaceContainerHighest,
                      child: const Center(child: Text("Poster")),
                    ),

              const SizedBox(width: 16),

              // Description
              SizedBox(
                width: width * 0.6 - 16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie.overview,
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                      maxLines: 8,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Genres
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Wrap(
            spacing: 10,
            children: movie.genreIds.take(5).map((id) {
              final genre = controller.getGenreNameById(id);
              return Chip(
                backgroundColor: Get.theme.colorScheme.surfaceContainerHighest,
                label: Text(
                  genre,
                  style: TextStyle(
                    color: Get.theme.colorScheme.onSurfaceVariant,
                    fontSize: 14,
                    fontFamily: 'Inter',
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
