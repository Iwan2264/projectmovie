import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projectmovie/controllers/movie_controllers/watchlist_controller.dart';

class WatchtimeScoreBar extends StatelessWidget {
  const WatchtimeScoreBar({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<WatchlistController>();
    final colorScheme = Theme.of(context).colorScheme;
    return Obx(() => Container(
      height: 60,
      color: colorScheme.primaryContainer,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Total Watch Time',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onPrimaryContainer,
                ),
              ),
              Text(
                '${controller.watchTime.toStringAsFixed(1)} hrs',
                style: TextStyle(
                  color: colorScheme.onPrimaryContainer,
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Mean Score',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onPrimaryContainer,
                ),
              ),
              Text(
                controller.meanScore > 0
                    ? controller.meanScore.toStringAsFixed(1)
                    : "-",
                style: TextStyle(
                  color: colorScheme.onPrimaryContainer,
                ),
              ),
            ],
          ),
        ],
      ),
    ));
  }
}