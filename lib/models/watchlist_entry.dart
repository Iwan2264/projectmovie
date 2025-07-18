import 'package:hive/hive.dart';
import 'movie.dart';

part 'watchlist_entry.g.dart';

@HiveType(typeId: 1)
class WatchlistEntry extends HiveObject {
  @HiveField(0)
  final Movie movie;
  @HiveField(1)
  WatchStatus status;
  @HiveField(2)
  double? score; // user's rating for this movie

  WatchlistEntry({
    required this.movie,
    required this.status,
    this.score,
  });
}

@HiveType(typeId: 2)
enum WatchStatus {
  @HiveField(0)
  planToWatch,
  @HiveField(1)
  watched,
  @HiveField(2)
  rewatched,
  @HiveField(3)
  dropped,
}