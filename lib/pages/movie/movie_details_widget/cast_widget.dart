import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/controllers/movie_controller.dart';

class CastAndCrewContainer extends StatelessWidget {
  final int movieId;
  final controller = Get.find<MovieController>();

  CastAndCrewContainer({required this.movieId, super.key}) {
    controller.fetchCredits(movieId);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final castList = controller.castList;

      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.all(16),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Cast & Crew',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                fontFamily: 'Roboto',
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 120,
              child: castList.isEmpty
                  ? const Center(child: Text("No cast available"))
                  : ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: castList.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 12),
                      itemBuilder: (context, index) {
                        final cast = castList[index];
                        final profileUrl = cast.profilePath.isNotEmpty
                            ? 'https://image.tmdb.org/t/p/w200${cast.profilePath}'
                            : null;

                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                                borderRadius: BorderRadius.circular(6),
                                image: DecorationImage(
                                  image: profileUrl != null
                                      ? NetworkImage(profileUrl)
                                      : const AssetImage('assets/images/avatar_placeholder.png') as ImageProvider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(height: 6),
                            SizedBox(
                              width: 60,
                              child: Text(
                                cast.name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                style: const TextStyle(fontSize: 12),
                              ),
                            ),
                          ],
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
