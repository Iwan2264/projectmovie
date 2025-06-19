import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/movie_controllers/movie_controller.dart';
import 'package:projectmovie/widgets/maybemarqueetext.dart';

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
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.fromLTRB(10, 2, 5, 5),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Cast & Crew!',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                fontFamily: 'Roboto',
              ),
            ),
            const SizedBox(height: 2),
            SizedBox(
              height: 115,
              child: castList.isEmpty
                  ? const Center(child: Text("No cast available"))
                  : ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: castList.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 10),
                      itemBuilder: (context, index) {
                        final cast = castList[index];
                        final profileUrl = cast.profilePath.isNotEmpty
                            ? 'https://image.tmdb.org/t/p/w200${cast.profilePath}'
                            : null;

                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 75,
                              height: 75,
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
                            const SizedBox(height: 1),
                            SizedBox(
                              width: 75,
                              child: Column(
                                children: [
                                  MaybeMarqueeText(
                                    text: cast.character,
                                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                                    maxWidth: 75,
                                  ),
                                  
                                  MaybeMarqueeText(
                                    text: cast.name,
                                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                                    maxWidth: 75,
                                  ),
                                ],
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
