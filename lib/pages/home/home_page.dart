import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projectmovie/controllers/movie_controllers/movie_controller.dart';
import 'package:projectmovie/controllers/navigation_controller.dart';
import 'package:projectmovie/pages/home/home_widgets/dynamic_header_widget.dart';
import 'package:projectmovie/pages/home/home_widgets/stat_widget.dart';
import 'package:projectmovie/pages/home/home_widgets/moviecard_widget.dart';
import 'package:projectmovie/pages/home/home_widgets/emptylist_widget.dart';
import 'package:projectmovie/pages/home/home_widgets/header_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final navController = Get.find<NavigationController>();
    final movieController = Get.find<MovieController>();

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
      appBar: AppBar(
        elevation: 2,
        title: const Text(
          '🎬 Project Movie List',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.surface,
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async => await movieController.fetchPopularMovies(),
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // Dynamic Header
              const DynamicHeaderWidget(),
              const SizedBox(height: 24),

              // Stats Section
              const StatsSectionWidget(),
              const SizedBox(height: 32),

              // Popular Movies Section
              SectionHeaderWidget(
                title: 'Popular Now',
                onTap: () => navController.selectedIndex.value = 0,
              ),
              const SizedBox(height: 12),
              Obx(() {
                final movies = movieController.movies.take(10).toList();
                if (movies.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                }

                return SizedBox(
                  height: 220,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: movies.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 12),
                    itemBuilder: (_, index) {
                      final movie = movies[index];
                      return EnhancedMovieCardWidget(movie: movie);
                    },
                  ),
                );
              }),

              const SizedBox(height: 32),

              // Watchlist Section
              SectionHeaderWidget(
                title: 'Your Watchlist',
                onTap: () => navController.selectedIndex.value = 1,
              ),
              const SizedBox(height: 12),
              const EmptyWatchlistWidget(),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
