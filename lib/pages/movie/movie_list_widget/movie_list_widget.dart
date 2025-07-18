import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:projectmovie/models/movie.dart';
import 'package:projectmovie/pages/movie/movie_details_page.dart';
import 'package:projectmovie/utils/date_formatter.dart';
import 'package:projectmovie/pages/movie/movie_list_widget/add_to_list_compact_widget.dart';

class MovieListItem extends StatelessWidget {
  final Movie movie;
  final double screenWidth;

  const MovieListItem({
    super.key,
    required this.movie,
    required this.screenWidth,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return GestureDetector(
      onTap: () => Get.to(() => MovieDetailsPage(movieId: movie.id)),
      child: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 2.5),
          width: screenWidth * 0.98,
          height: 100,
          child: Stack(
            children: [
              // Card background
              Container(
                width: screenWidth * 0.98,
                height: 100,
                decoration: BoxDecoration(
                  color: colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              // Poster
              Positioned(
                left: 2,
                top: 2,
                child: Container(
                  width: 68,
                  height: 96,
                  decoration: BoxDecoration(
                    color: colorScheme.onSurface.withAlpha((0.12 * 255).round()),
                    borderRadius: BorderRadius.circular(6),
                    image: movie.posterPath.isNotEmpty
                        ? DecorationImage(
                            image: NetworkImage('https://image.tmdb.org/t/p/w200${movie.posterPath}'),
                            fit: BoxFit.cover,
                          )
                        : null,
                    boxShadow: [
                      BoxShadow(
                        color: colorScheme.shadow.withAlpha((0.25 * 255).round()),
                        blurRadius: 4,
                        offset: const Offset(0, 4),
                        spreadRadius: 1,
                      )
                    ],
                  ),
                ),
              ),
              // Release Date
              Positioned(
                left: screenWidth * 0.825,
                top: 4,
                child: SizedBox(
                  width: screenWidth * 0.14,
                  child: Text(
                    formatDate(movie.releaseDate),
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: colorScheme.onSurface.withAlpha((0.8 * 255).round()),
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Roboto Slab',
                      fontSize: 10,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
              ),
              // Add to List button
Positioned(
  left: screenWidth * 0.62,
  top: 61,
  child: SizedBox(
    width: screenWidth * 0.35,
    height: 28, // match compact button height
    child: AddToListCompactButton(movie: movie),
  ),
),
              // Rating bar and score
              Positioned(
                left: screenWidth * 0.225,
                top: 60,
                child: SizedBox(
                  width: screenWidth * 0.4,
                  child: Row(
                    children: [
                      RatingBarIndicator(
                        rating: movie.voteAverage / 2,
                        itemBuilder: (context, index) => Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        itemCount: 5,
                        itemSize: 20.0,
                        unratedColor: colorScheme.outlineVariant.withAlpha((0.3 * 255).round()),
                        direction: Axis.horizontal,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        movie.voteAverage.toStringAsFixed(1),
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurface,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                          fontFamily: 'Roboto',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // User Count
              Positioned(
                left: screenWidth * 0.20,
                top: 80,
                child: SizedBox(
                  width: screenWidth * 0.4,
                  child: Text(
                    'User Count TBA',
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: colorScheme.onSurface.withAlpha((0.8 * 255).round()),
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Roboto Slab',
                      fontSize: 10,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              // Overview
              Positioned(
                left:screenWidth * 0.21, 
                top: 25,
                child: SizedBox(
                  width: screenWidth * 0.75,
                  height: 30,
                  child: Text(
                    movie.overview,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurface,
                      fontWeight: FontWeight.w300,
                      fontFamily: 'Roboto Condensed',
                      fontSize: 11,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              // Movie title
              Positioned(
                left: screenWidth * 0.205,
                top: 3.5,
                child: SizedBox(
                  width: screenWidth * 0.7,
                  height: 20,
                  child: Text(
                    movie.title,
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: colorScheme.onSurface,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Roboto',
                      fontSize: 16,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}