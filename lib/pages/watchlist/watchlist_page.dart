import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projectmovie/controllers/movie_controllers/watchlist_controller.dart';
import 'package:projectmovie/pages/watchlist/widgets/watchtime_score_bar.dart';
import 'package:projectmovie/pages/watchlist/widgets/watchlist_stats_chart.dart';

class WatchlistPage extends StatelessWidget {
  WatchlistPage({Key? key}) : super(key: key);

  final WatchlistController controller = Get.find<WatchlistController>();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return SafeArea(
      child: Scaffold(
        backgroundColor: colorScheme.surface,
        body: Column(
          children: [
            Container(
              width: double.infinity,
              height: 50,
              color: colorScheme.primary,
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "My Watchlist",
                style: TextStyle(
                  color: colorScheme.onPrimary,
                  fontSize: 22,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const WatchtimeScoreBar(),
            // Add more widgets below as needed
            Obx(() => WatchlistStatsChart(
              watched: controller.watched,
              planToWatch: controller.planToWatch,
              rewatched: controller.rewatched,
              dropped: controller.dropped,
            )),
          ],
        ),
      ),
    );
  }
}
