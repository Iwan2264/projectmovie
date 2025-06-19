import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projectmovie/controllers/movie_controllers/streaming_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class StreamingWidget extends StatelessWidget {
  final int movieId;

  const StreamingWidget({super.key, required this.movieId});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(StreamingController());
    controller.fetchPlatforms(movieId);

    return Obx(() {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(12),
        ),
        child: controller.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : controller.notAvailable.value
                ? Text(
                    'This title isn’t streaming in your region!',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontFamily: 'Roboto',
                          color: Theme.of(context).colorScheme.error,
                        ),
                    textAlign: TextAlign.center,
                  )
                : controller.availableInCinemas.value
                    ? Text(
                        'Available in Cinemas!',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontFamily: 'Roboto',
                              color: Theme.of(context).colorScheme.primary,
                            ),
                        textAlign: TextAlign.center,
                      )
                    : controller.platforms.isEmpty
                        ? const SizedBox() // No platforms to show
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Available On!',
                                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                      fontFamily: 'Roboto',
                                    ),
                              ),
                              const SizedBox(height: 6),
                              SizedBox(
                                height: 70,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: controller.platforms.length,
                                  itemBuilder: (context, index) {
                                    final platform = controller.platforms[index];
                                    final logoUrl = 'https://image.tmdb.org/t/p/original${platform.logoPath}';
                                    return GestureDetector(
                                      onTap: () async {
                                        final uri = Uri.parse(platform.movieUrl);
                                        if (await canLaunchUrl(uri)) {
                                          await launchUrl(uri, mode: LaunchMode.externalApplication);
                                        } else {
                                          Get.snackbar('Error', 'Could not launch link');
                                        }
                                      },
                                      child: Padding(
                                       padding: const EdgeInsets.only(right: 10),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(6),
                                          child: Image.network(
                                            logoUrl,
                                            fit: BoxFit.contain,
                                            filterQuality: FilterQuality.high,
                                            loadingBuilder: (context, child, loadingProgress) {
                                              if (loadingProgress == null) return child;
                                              return const Center(child: CircularProgressIndicator());
                                            },
                                            errorBuilder: (context, error, stackTrace) {
                                              return const Icon(Icons.broken_image, size: 40);
                                            },
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                        ),
      );
    });
  }
}