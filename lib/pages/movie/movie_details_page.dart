import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projectmovie/controllers/movie_controller.dart';
import 'package:projectmovie/pages/movie/movie_details_widget/cast_widget.dart';
import 'package:projectmovie/pages/movie/movie_details_widget/poster_widget.dart';
import 'package:projectmovie/pages/movie/movie_details_widget/add_rate_widget.dart';
import 'package:projectmovie/pages/movie/movie_details_widget/trailer_widget.dart';


class MovieDetailsPage extends StatelessWidget {
  final int movieId;
  const MovieDetailsPage({super.key, required this.movieId});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MovieController>();
    final movie = controller.getMovieById(movieId);
    final width = MediaQuery.of(context).size.width;

    if (movie == null) {
      return Scaffold(
        appBar: AppBar(title: const Text("Movie Details")),
        body: const Center(child: Text('Movie not found')),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top AppBar
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                color: Theme.of(context).appBarTheme.backgroundColor ??
                    Theme.of(context).colorScheme.surface,
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Get.back(),
                      icon: Icon(Icons.arrow_back, color: Theme.of(context).iconTheme.color),
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          movie.title,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Inter',
                              ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 48),
                  ],
                ),
              ),

              //Trailer
              MovieTrailerInlineWidget(movieId: movie.id),

              // Movie Poster and Description
              MoviePosterDescription(movie: movie, width: width),

              // Cast & Crew
              CastAndCrewContainer(movieId: movie.id),
              const SizedBox(height: 16),

              // Rating
              WatchlistAndRating(
                onWatchlistTap: () => Get.snackbar('Watchlist', 'Movie added to your watchlist!'),
                onRateTap: () {
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: const Text("Rate Movie"),
                      content: const Text("Add your custom star rating UI here."),
                    ),
                  );
                },
              ),

              const Padding(
                padding: EdgeInsets.only(left: 16),
                child: Text(
                  'Streaming On!',
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Inter',
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 8),

              // Streaming platforms (placeholder)
              SizedBox(
                height: 70,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: 5,
                  itemBuilder: (context, index) => Container(
                    margin: const EdgeInsets.only(right: 10),
                    width: 100,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surfaceVariant,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

