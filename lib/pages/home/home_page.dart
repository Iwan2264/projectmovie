import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projectmovie/controllers/movie_controllers/movie_controller.dart';
import 'package:projectmovie/controllers/navigation_controller.dart';
import 'package:projectmovie/models/movie.dart';
import 'package:projectmovie/pages/movie/movie_details_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final navController = Get.find<NavigationController>();
    final movieController = Get.find<MovieController>();
    final screenWidth = MediaQuery.of(context).size.width;
    final isDark = Get.isDarkMode;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        elevation: 2,
        title: const Text(
          '🎬 ProjectMovie',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.surface,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () {
              navController.selectedIndex.value = 2; // Settings tab
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async => await movieController.fetchPopularMovies(),
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Welcome message
            Text(
              'Good Morning, Safwan!',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
            const SizedBox(height: 20),

            //Popular Movies
            _buildSectionHeader(
              context,
              title: '🔥 Popular Now',
              onTap: () => navController.selectedIndex.value = 0,
            ),
            const SizedBox(height: 12),
            Obx(() {
              final movies = movieController.movies.take(10).toList();
              if (movies.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              }

              return SizedBox(
                height: 210,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: movies.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 12),
                  itemBuilder: (_, index) {
                    final movie = movies[index];
                    return _buildMovieCard(movie, screenWidth, context, isDark);
                  },
                ),
              );
            }),

            const SizedBox(height: 32),

            //Watchlist
            _buildSectionHeader(
              context,
              title: '🎯 Your Watchlist',
              onTap: () => navController.selectedIndex.value = 1,
            ),
            const SizedBox(height: 12),
            Container(
              height: 110,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.primaryContainer.withOpacity(0.5),
                    Theme.of(context).colorScheme.secondaryContainer.withOpacity(0.4),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Center(
                child: Text(
                  'Your saved movies will show up here 📁',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context,
      {required String title, required VoidCallback onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        TextButton(
          onPressed: onTap,
          child: const Text('See all'),
        ),
      ],
    );
  }

  Widget _buildMovieCard(
      Movie movie, double screenWidth, BuildContext context, bool isDark) {
    return GestureDetector(
      onTap: () => Get.to(() => MovieDetailsPage(movieId: movie.id)),
      child: Container(
        width: 130,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: Theme.of(context).colorScheme.surfaceVariant,
          boxShadow: [
            BoxShadow(
              color: isDark ? Colors.black54 : Colors.black12,
              blurRadius: 6,
              offset: const Offset(0, 4),
            ),
          ],
          image: movie.posterPath.isNotEmpty
              ? DecorationImage(
                  image: NetworkImage('https://image.tmdb.org/t/p/w200${movie.posterPath}'),
                  fit: BoxFit.cover,
                )
              : null,
        ),
        child: movie.posterPath.isEmpty
            ? Center(
                child: Icon(
                  Icons.image_not_supported_outlined,
                  color: Theme.of(context).iconTheme.color,
                  size: 40,
                ),
              )
            : null,
      ),
    );
  }
}
