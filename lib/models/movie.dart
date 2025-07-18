import 'package:hive/hive.dart';

part 'movie.g.dart';

@HiveType(typeId: 0)
class Movie extends HiveObject {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String overview;
  @HiveField(3)
  final String posterPath;
  @HiveField(4)
  final String backdropPath;
  @HiveField(5)
  final double voteAverage;
  @HiveField(6)
  final String releaseDate;
  @HiveField(7)
  final List<int> genreIds;
  @HiveField(8)
  final int voteCount;
  @HiveField(9)
  final String? trailerKey;
  @HiveField(10)
  final int runtime; // in minutes

  Movie({
    required this.id,
    required this.title,
    required this.overview,
    required this.posterPath,
    required this.backdropPath,
    required this.voteAverage,
    required this.releaseDate,
    required this.genreIds,
    required this.voteCount,
    this.trailerKey,
    required this.runtime,
  });

  factory Movie.fromJson(Map<String, dynamic> json) => Movie(
    id: json['id'],
    title: json['title'] ?? '',
    overview: json['overview'] ?? '',
    posterPath: json['poster_path'] ?? '',
    backdropPath: json['backdrop_path'] ?? '',
    voteAverage: (json['vote_average'] ?? 0).toDouble(),
    releaseDate: json['release_date'] ?? '',
    genreIds: List<int>.from(json['genre_ids'] ?? []),
    voteCount: json['vote_count'] ?? 0,
    trailerKey: json['trailerKey'],
    runtime: json['runtime'] ?? 0,
  );
}