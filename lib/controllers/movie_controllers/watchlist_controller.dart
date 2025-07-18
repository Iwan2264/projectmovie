import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:projectmovie/models/movie.dart';
import 'package:projectmovie/models/watchlist_entry.dart';

class WatchlistController extends GetxController {
  final RxList<WatchlistEntry> _watchlist = <WatchlistEntry>[].obs;
  final GetStorage _storage = GetStorage();
  static const _storageKey = 'watchlist';

  List<WatchlistEntry> get watchlist => _watchlist;

  @override
  void onInit() {
    super.onInit();
    _loadWatchlist();
    ever(_watchlist, (_) => _saveWatchlist());
  }

  void _loadWatchlist() {
    final rawList = _storage.read<List>(_storageKey) ?? [];
    final loaded = rawList.map((e) => WatchlistEntry.fromJson(Map<String, dynamic>.from(e))).toList();
    _watchlist.assignAll(loaded);
  }

  void _saveWatchlist() {
    final rawList = _watchlist.map((e) => e.toJson()).toList();
    _storage.write(_storageKey, rawList);
  }

  /// Use this if you have the original movie JSON from the API
  void addToWatchlistFromJson(Map<String, dynamic> movieJson) {
    final movie = Movie.fromJson(movieJson);
    if (!isInWatchlist(movie)) {
      _watchlist.add(WatchlistEntry.fromApiJson(movieJson));
      Get.snackbar("Added", "${movie.title} added to your watchlist");
    }
  }

  /// Use this if you only have Movie object and accept limited serialization
  void addToWatchlist(Movie movie) {
    if (!isInWatchlist(movie)) {
      _watchlist.add(WatchlistEntry(movie: movie));
      Get.snackbar("Added", "${movie.title} added to your watchlist");
    }
  }

  void removeFromWatchlist(Movie movie) {
    _watchlist.removeWhere((entry) => entry.movie.id == movie.id);
    Get.snackbar("Removed", "${movie.title} removed from your watchlist");
  }

  bool isInWatchlist(Movie movie) {
    return _watchlist.any((entry) => entry.movie.id == movie.id);
  }

  WatchStatus? getStatus(Movie movie) {
    return _watchlist.firstWhereOrNull((entry) => entry.movie.id == movie.id)?.status;
  }

  void setStatus(Movie movie, WatchStatus status) {
    final entry = _watchlist.firstWhereOrNull((entry) => entry.movie.id == movie.id);
    if (entry != null) {
      entry.status = status;
      _watchlist.refresh();
    }
  }

  void setScore(Movie movie, double score) {
    final entry = _watchlist.firstWhereOrNull((entry) => entry.movie.id == movie.id);
    if (entry != null) {
      entry.score = score;
      _watchlist.refresh();
    }
  }

  void setWatchTime(Movie movie, double hours) {
    final entry = _watchlist.firstWhereOrNull((entry) => entry.movie.id == movie.id);
    if (entry != null) {
      entry.watchTime = hours;
      _watchlist.refresh();
    }
  }

  int get watched => _watchlist.where((e) => e.status == WatchStatus.watched).length;
  int get planToWatch => _watchlist.where((e) => e.status == WatchStatus.planToWatch).length;
  int get rewatched => _watchlist.where((e) => e.status == WatchStatus.rewatched).length;
  int get dropped => _watchlist.where((e) => e.status == WatchStatus.dropped).length;
  int get total => _watchlist.length;

  double get watchTime =>
      _watchlist.fold(0.0, (sum, entry) => sum + entry.watchTime);

  double get meanScore {
    final scores = _watchlist.map((e) => e.score).where((s) => s > 0).toList();
    if (scores.isEmpty) return 0;
    return scores.reduce((a, b) => a + b) / scores.length;
  }
}