import 'package:get/get.dart';
import 'package:projectmovie/models/movie.dart';

class WatchlistController extends GetxController {
  final RxList<Movie> _watchlist = <Movie>[].obs;

  List<Movie> get watchlist => _watchlist;

  void addToWatchlist(Movie movie) {
    if (!isInWatchlist(movie)) {
      _watchlist.add(movie);
      Get.snackbar("Added", "${movie.title} added to your watchlist");
    }
  }

  void removeFromWatchlist(Movie movie) {
    _watchlist.removeWhere((m) => m.id == movie.id);
    Get.snackbar("Removed", "${movie.title} removed from your watchlist");
  }

  bool isInWatchlist(Movie movie) {
    return _watchlist.any((m) => m.id == movie.id);
  }

  void toggleWatchlist(Movie movie) {
    isInWatchlist(movie) ? removeFromWatchlist(movie) : addToWatchlist(movie);
  }
}
