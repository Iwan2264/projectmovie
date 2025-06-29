import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projectmovie/controllers/movie_controllers/movie_controller.dart';
import 'package:projectmovie/pages/movie/movie_list_widget/movie_search_widget.dart';
import 'package:projectmovie/pages/movie/movie_list_widget/movie_list_widget.dart';

class MovieListPage extends GetView<MovieController> {
  final TextEditingController searchController = TextEditingController();

  MovieListPage({super.key}) {
    Get.put(MovieController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Column(
          children: [
            MovieSearchBar(controller: searchController),
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (controller.movies.isEmpty) {
                  return const Center(child: Text('No movies found.'));
                }

                final screenWidth = MediaQuery.of(context).size.width;
                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 2.0),
                  itemCount: controller.movies.length,
                  itemBuilder: (_, index) {
                    final movie = controller.movies[index];
                    return MovieListItem(
                      movie: movie,
                      screenWidth: screenWidth,
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}