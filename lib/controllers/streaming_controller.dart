import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:projectmovie/models/streaming_platform.dart';

class StreamingController extends GetxController {
  final platforms = <StreamingPlatform>[].obs;
  final isLoading = false.obs;
  final availableInCinemas = false.obs;
  final notAvailable = false.obs;

  final String _apiKey = dotenv.env['APIKEY'] ?? '';
  final String _baseUrl = 'https://api.themoviedb.org/3';

  Future<void> fetchPlatforms(int movieId, {String region = 'IN'}) async {
    isLoading.value = true;
    platforms.clear();
    availableInCinemas.value = false;
    notAvailable.value = false;

    final url = Uri.parse('$_baseUrl/movie/$movieId/watch/providers?api_key=$_apiKey');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final results = data['results'];
        final regionData = results[region];

        if (regionData == null) {
          notAvailable.value = true;
        } else if (regionData['flatrate'] != null) {
          final link = regionData['link'];
          final List<StreamingPlatform> loadedPlatforms = [];

          for (var item in regionData['flatrate']) {
            final logoPath = item['logo_path'];
            loadedPlatforms.add(StreamingPlatform(
              name: item['provider_name'],
              logoUrl: 'https://image.tmdb.org/t/p/original${item['logo_path']}',
              movieUrl: link,
              logoPath: logoPath,
            ));
          }

          platforms.assignAll(loadedPlatforms);
        } else if (regionData['buy'] != null || regionData['rent'] != null) {
          // If the movie is available for buy/rent, assume it's "Available in Cinemas"
          availableInCinemas.value = true;
        } else {
          notAvailable.value = true;
        }
      } else {
        Get.snackbar("Error", "Failed to load streaming data");
      }
    } catch (e) {
      Get.snackbar("Error", "Network error while fetching streaming data");
    } finally {
      isLoading.value = false;
    }
  }
}
