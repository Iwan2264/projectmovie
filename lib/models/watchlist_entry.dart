import 'package:projectmovie/models/movie.dart';

enum WatchStatus { planToWatch, watched, rewatched, dropped }

class WatchlistEntry {
  final Movie movie;
  WatchStatus status;
  double score;
  double watchTime;

  WatchlistEntry({
    required this.movie,
    this.status = WatchStatus.planToWatch,
    this.score = 0.0,
    this.watchTime = 0.0,
  });

  Map<String, dynamic> toJson() => {
        'movie': _originalMovieJson,
        'status': status.index,
        'score': score,
        'watchTime': watchTime,
      };

  final Map<String, dynamic> _originalMovieJson = {};

  static WatchlistEntry fromApiJson(Map<String, dynamic> movieJson) => WatchlistEntry(
        movie: Movie.fromJson(movieJson),
      ).._originalMovieJson.addAll(movieJson);

  static WatchlistEntry fromJson(Map<String, dynamic> json) => WatchlistEntry(
        movie: Movie.fromJson(Map<String, dynamic>.from(json['movie'])),
        status: WatchStatus.values[json['status']],
        score: (json['score'] ?? 0.0).toDouble(),
        watchTime: (json['watchTime'] ?? 0.0).toDouble(),
      ).._originalMovieJson.addAll(Map<String, dynamic>.from(json['movie']));
}