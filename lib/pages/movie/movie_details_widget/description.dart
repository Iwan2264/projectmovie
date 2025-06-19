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
                    borderRadius: BorderRadius.circular(6),
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
                      borderRadius: BorderRadius.circular(6),
                      color: Theme.of(context).colorScheme.surfaceContainerHighest,
                    ),
                    child: const Center(child: Text("Poster")),
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
                          style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context).colorScheme.onSurface,
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
          ),
        
        ],
      ),
    );
  }
}
