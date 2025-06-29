import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projectmovie/controllers/movie_controllers/movie_controller.dart';

class MovieSearchBar extends StatelessWidget {
  final TextEditingController controller;

  const MovieSearchBar({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final movieController = Get.find<MovieController>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child:  Column(
        children: [
          // Search Bar
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context)
                  .colorScheme
                  .surfaceContainerHighest
                  .withAlpha((0.5 * 255).toInt()),
              borderRadius: BorderRadius.circular(12),
            ),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: 'Search movies, actors, genres...',
                border: InputBorder.none,
                contentPadding: const EdgeInsets.all(16),
                prefixIcon: const Icon(Icons.search),
                suffixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.tune),
                      onPressed: () {
                        Get.snackbar('Filters', 'Advanced filters coming soon!');
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        controller.clear();
                        movieController.searchQuery.value = '';
                        movieController.fetchPopularMovies();
                      },
                    ),
                  ],
                ),
              ),
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
        ],
      ),
    );
  }
}