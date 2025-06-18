import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projectmovie/controllers/movie_controller.dart';
import 'movie_details_page.dart';
import 'package:projectmovie/utils/date_formatter.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class MovieListPage extends GetView<MovieController> {
  final TextEditingController searchController = TextEditingController();

  MovieListPage({super.key}) {
    Get.put(MovieController());
  }

  @override
  Widget build(BuildContext context) {
    //final screenWidth = MediaQuery.of(context).size.width; // Uncomment if you need screen width for responsive design

    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Search movies...',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    searchController.clear();
                    controller.searchQuery.value = '';
                    controller.fetchPopularMovies();
                  },
                ),
              ),
              onChanged: (value) {
                controller.searchQuery.value = value;
                if (value.isEmpty) {
                  controller.fetchPopularMovies();
                } else {
                  controller.searchMovies(value);
                }
              },
            ),
          ),
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
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                itemCount: controller.movies.length,
                itemBuilder: (_, index) {
                  final movie = controller.movies[index];
                  return GestureDetector(
                    onTap: () => Get.to(() => MovieDetailsPage(movieId: movie.id)),
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      width: screenWidth * 0.96,
                      height: 90,
                      child: Stack(
                        children: [
                          Container( // Background container
                            width: screenWidth * 0.96,
                            height: 90,
                            decoration: BoxDecoration(
                              color: const Color(0xFFC7C7C7),
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),

                          Positioned( // Poster image
                            left: 1,
                            top: 1,
                            child: Container(
                              width: 68,
                              height: 88,
                              decoration: BoxDecoration(
                                color: const Color(0xFFBDBDBD),
                                borderRadius: BorderRadius.circular(6),
                                image: movie.posterPath.isNotEmpty
                                    ? DecorationImage(
                                        image: NetworkImage('https://image.tmdb.org/t/p/w200${movie.posterPath}'),
                                        fit: BoxFit.cover,
                                      )
                                    : null,
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color(0x3F000000),
                                    blurRadius: 4,
                                    offset: Offset(0, 4),
                                    spreadRadius: 1,
                                  )
                                ],
                              ),
                            ),
                          ),

                          Positioned( // Release date
                            left: screenWidth * 0.80,
                            top: 4,
                            child: SizedBox(
                              width: screenWidth * 0.14,
                              child: Text(
                                formatDate(movie.releaseDate),
                                style: const TextStyle(
                                  color: Color(0xFF212121),
                                  fontSize: 10,
                                  fontFamily: 'Roboto Slab',
                                  fontWeight: FontWeight.w600,
                                ),
                                textAlign: TextAlign.right,
                              ),
                            ),
                          ),

                          Positioned( // Add to List button
                            left: screenWidth * 0.60,
                            top: 55,
                            child: Container(
                              width: screenWidth * 0.35,
                              height: 33,
                                decoration: BoxDecoration(
                                color: const Color(0xFF666666),
                                borderRadius: BorderRadius.circular(6),
                                ),
                              child: const Center(
                                child: Text(
                                  'Add to List',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),

                          Positioned( // Rating and average vote
                            left: screenWidth * 0.22,
                            top: 60,
                            child: SizedBox(
                              width: screenWidth * 0.4,
                              child: Row(
                                children: [
                                  RatingBarIndicator(
                                    rating: movie.voteAverage / 2, // Convert from 10 to 5 scale
                                    itemBuilder: (context, index) => Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    itemCount: 5,
                                    itemSize: 20.0,
                                    unratedColor: Colors.grey[300],
                                    direction: Axis.horizontal,
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    movie.voteAverage.toStringAsFixed(1),
                                    style: const TextStyle(
                                      color: Color(0xFF212121),
                                      fontSize: 12,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          Positioned( // Movie overview
                            left: 75,
                            top: 23,
                            child: SizedBox(
                              width: screenWidth * 0.74,
                              height: 30, // You may tweak this if needed
                              child: Text(
                                movie.overview,
                                style: const TextStyle(
                                  color: Color(0xFF212121),
                                  fontSize: 11,
                                  fontFamily: 'Roboto Condensed',
                                  fontWeight: FontWeight.w300,
                                ),
                                maxLines: 2, // ✅ Allows two lines
                                overflow: TextOverflow.ellipsis, // ✅ Fades off if longer than 2 lines
                              ),
                            ),
                          ),

                          Positioned( // Movie title
                            left: 75,
                            top: 2,
                            child: SizedBox(
                              width: screenWidth * 0.7,
                              height: 20,
                              child: Text(
                                movie.title,
                                style: const TextStyle(
                                  color: Color(0xFF212121),
                                  fontSize: 16,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w700,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }),
          ),
        ],
      )
    );
  }
}
