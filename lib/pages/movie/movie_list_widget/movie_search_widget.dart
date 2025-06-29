import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projectmovie/controllers/movie_controllers/movie_controller.dart';

class MovieSearchBar extends StatelessWidget {
  final TextEditingController controller;

  const MovieSearchBar({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final movieController = Get.find<MovieController>();
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          // Search Bar
          Container(
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerHighest.withAlpha((0.5 * 255).toInt()),
              borderRadius: BorderRadius.circular(12),
            ),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: 'Search movies, actors, genres...',
                border: InputBorder.none,
                contentPadding: const EdgeInsets.all(16),
                prefixIcon: Icon(Icons.search, color: colorScheme.onSurfaceVariant),
                suffixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.tune, color: colorScheme.onSurfaceVariant),
                      onPressed: () {
                        Get.snackbar('Filters', 'Advanced filters coming soon!');
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.clear, color: colorScheme.onSurfaceVariant),
                      onPressed: () {
                        controller.clear();
                        movieController.searchQuery.value = '';
                        movieController.fetchPopularMovies();
                      },
                    ),
                  ],
                ),
              ),
              style: TextStyle(color: colorScheme.onSurface),
              onChanged: (value) {
                movieController.searchQuery.value = value;
                if (value.isEmpty) {
                  movieController.fetchPopularMovies();
                } else {
                  movieController.searchMovies(value);
                }
              },
            ),
          ),
          const SizedBox(height: 12),
          // Quick Filter Chips (optional, Material 3 style)
          SizedBox(
            height: 40,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                ...['Action', 'Comedy', 'Drama', 'Sci-Fi', 'Horror', 'Romance'].map(
                  (genre) => Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: FilterChip(
                      label: Text(
                        genre,
                        style: TextStyle(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                      onSelected: (selected) {
                        Get.snackbar('Filter', 'Selected: $genre');
                      },
                      backgroundColor: colorScheme.surfaceContainerHighest.withAlpha((0.5 * 255).toInt()),
                      selectedColor: colorScheme.primaryContainer,
                      checkmarkColor: colorScheme.onPrimaryContainer,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}