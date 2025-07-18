import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projectmovie/controllers/movie_controllers/movie_controller.dart';
import 'package:projectmovie/pages/movie/movie_details_widget/cast_widget.dart';
import 'package:projectmovie/pages/movie/movie_details_widget/description.dart';
import 'package:projectmovie/pages/movie/movie_details_widget/rate_widget.dart';
import 'package:projectmovie/pages/movie/movie_details_widget/trailer_widget.dart';
import 'package:projectmovie/pages/movie/movie_details_widget/streaming_widget.dart';
import 'package:projectmovie/widgets/addbutton_widget.dart';

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
        child: Column(
          children: [
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

            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MovieTrailerInlineWidget(movieId: movie.id),
                    MoviePosterDescription(movie: movie, width: width),
                    CastAndCrewContainer(movieId: movie.id),
                    const SizedBox(height: 10),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),  
                        color: Theme.of(context).colorScheme.surfaceContainerHighest,
                      ),  
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AddToListButton(
                          movie: movie,
                        ),
                          Padding(
                            padding: const EdgeInsets.only(right: 30),
                              child: RateButtonWidget(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (_) => const AlertDialog(
                                      title: Text("Rate Movie"),
                                      content: Text("Add your custom star rating UI here."),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),

                    StreamingWidget(movieId: movie.id),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
