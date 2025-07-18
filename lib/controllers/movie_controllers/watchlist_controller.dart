import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:projectmovie/models/movie.dart';
import 'package:projectmovie/models/watchlist_entry.dart';

class WatchlistController extends GetxController {
  late Box<WatchlistEntry> _watchlistBox;
  final RxList<WatchlistEntry> _watchlist = <WatchlistEntry>[].obs;

  List<WatchlistEntry> get watchlist => _watchlist;

  @override
  void onInit() {
    super.onInit();
    _watchlistBox = Hive.box<WatchlistEntry>('watchlist');
    _loadWatchlist();
  }

  void _loadWatchlist() {
    _watchlist.assignAll(_watchlistBox.values);
  }

  void addToWatchlist(Movie movie, {WatchStatus status = WatchStatus.planToWatch, double? score}) {
    if (!isInWatchlist(movie)) {
      final entry = WatchlistEntry(movie: movie, status: status, score: score);
      _watchlistBox.put(movie.id, entry);
      _watchlist.add(entry);
      Get.snackbar("Added", "${movie.title} added to your watchlist");
    }
  }

  void removeFromWatchlist(Movie movie) {
    _watchlistBox.delete(movie.id);
    _watchlist.removeWhere((e) => e.movie.id == movie.id);
    Get.snackbar("Removed", "${movie.title} removed from your watchlist");
  }

  bool isInWatchlist(Movie movie) {
    return _watchlist.any((e) => e.movie.id == movie.id);
  }

  WatchStatus? getStatus(Movie movie) {
    final entry = _watchlist.firstWhereOrNull((e) => e.movie.id == movie.id);
    return entry?.status;
  }

  void setStatus(Movie movie, WatchStatus status) {
    final entry = _watchlist.firstWhereOrNull((e) => e.movie.id == movie.id);
    if (entry != null) {
      entry.status = status;
      entry.save();
      _watchlist.refresh();
      Get.snackbar("Updated", "${movie.title} status updated");
    }
  }

  double? getScore(Movie movie) {
    final entry = _watchlist.firstWhereOrNull((e) => e.movie.id == movie.id);
    return entry?.score;
  }

  void setScore(Movie movie, double score) {
    final entry = _watchlist.firstWhereOrNull((e) => e.movie.id == movie.id);
    if (entry != null) {
      entry.score = score;
      // Auto-mark as watched when a score is set
      if (entry.status != WatchStatus.watched && entry.status != WatchStatus.rewatched) {
        entry.status = WatchStatus.watched;
      }
      entry.save();
      _watchlist.refresh();
      Get.snackbar("Updated", "${movie.title} score updated");
    }
  }

  // ---- STATISTICS ----
  double get meanScore {
    final scoredEntries = _watchlist.where((e) => e.score != null).toList();
    if (scoredEntries.isEmpty) return 0.0;
    final totalScore = scoredEntries.map((e) => e.score!).reduce((a, b) => a + b);
    return totalScore / scoredEntries.length;
  }

  /// Watch time: sum of runtimes for all "watched" movies, in hours.
  double get watchTime {
    final watchedEntries = _watchlist.where((e) => e.status == WatchStatus.watched || e.status == WatchStatus.rewatched);
    final totalMinutes = watchedEntries.fold<int>(
      0,
      (sum, entry) => sum + (entry.movie.runtime),
    );
    return totalMinutes / 60.0;
  }

  int get watched => _watchlist.where((e) => e.status == WatchStatus.watched).length;
  int get planToWatch => _watchlist.where((e) => e.status == WatchStatus.planToWatch).length;
  int get rewatched => _watchlist.where((e) => e.status == WatchStatus.rewatched).length;
  int get dropped => _watchlist.where((e) => e.status == WatchStatus.dropped).length;
  int get total => _watchlist.length;
}