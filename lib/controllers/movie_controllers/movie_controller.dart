import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:projectmovie/models/movie.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '/utils/genre_helper.dart';
import 'package:projectmovie/models/cast.dart';

class MovieController extends GetxController {
  final movies = <Movie>[].obs;
  final isLoading = false.obs;
  final searchQuery = ''.obs;

  final String _apiKey = dotenv.env['APIKEY'] ?? '';
  final String _baseUrl = 'https://api.themoviedb.org/3';
  

  @override
  void onInit() {
    super.onInit();
    fetchPopularMovies();
  }

  Future<void> fetchPopularMovies() async {
    isLoading.value = true;
    final url = Uri.parse('$_baseUrl/movie/popular?api_key=$_apiKey');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final results = jsonDecode(response.body)['results'] as List;
        movies.value = results.map((json) => Movie.fromJson(json)).toList();
      } else {
        movies.clear();
        Get.snackbar('Error', 'Failed to load movies');
      }
    } catch (e) {
      movies.clear();
      Get.snackbar('Error', 'Failed to connect to server');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> searchMovies(String query) async {
    if (query.isEmpty) return;
    isLoading.value = true;
    final url = Uri.parse('$_baseUrl/search/movie?api_key=$_apiKey&query=$query');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final results = jsonDecode(response.body)['results'] as List;
        movies.value = results.map((json) => Movie.fromJson(json)).toList();
      } else {
        movies.clear();
        Get.snackbar('Error', 'Failed to search movies');
      }
    } catch (e) {
      movies.clear();
      Get.snackbar('Error', 'Search failed');
    } finally {
      isLoading.value = false;
    }
  }

  List<Movie> get filteredMovies => searchQuery.isEmpty
      ? movies
      : movies
          .where((m) =>
              m.title.toLowerCase().contains(searchQuery.value.toLowerCase()))
          .toList();

  Movie? getMovieById(int id) => movies.firstWhereOrNull((m) => m.id == id);
  List<String> getGenres(Movie movie) {
    return movie.genreIds.map((id) => genreMap[id] ?? 'Unknown').toList();
  }
  String getGenreNameById(int id) {
    return genreMap[id] ?? 'Unknown';
  }
  Future<String?> fetchYoutubeTrailerKey(int movieId) async {
    final url = Uri.parse('$_baseUrl/movie/$movieId/videos?api_key=$_apiKey');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final results = jsonDecode(response.body)['results'] as List;
        final ytTrailer = results.firstWhere(
          (video) =>
              video['site'] == 'YouTube' &&
              video['type'] == 'Trailer' &&
              video['key'] != null,
          orElse: () => null,
        );
        return ytTrailer != null ? ytTrailer['key'] : null;
      }
    } catch (_) {}
    return null;
  }
  var castList = <Cast>[].obs;
  Future<void> fetchCredits(int movieId) async {
    final url = Uri.parse('$_baseUrl/movie/$movieId/credits?api_key=$_apiKey');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        castList.value = (data['cast'] as List).map((json) => Cast.fromJson(json)).toList();
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to load cast");
    }
  }
}

