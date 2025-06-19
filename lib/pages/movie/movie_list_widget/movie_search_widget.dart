import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projectmovie/controllers/movie_controller.dart';

class MovieSearchBar extends StatelessWidget {
  final TextEditingController controller;

  const MovieSearchBar({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final movieController = Get.find<MovieController>();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: 'Search movies...',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          prefixIcon: const Icon(Icons.search),
          suffixIcon: IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () {
              controller.clear();
              movieController.searchQuery.value = '';
              movieController.fetchPopularMovies();
            },
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
    );
  }
}
