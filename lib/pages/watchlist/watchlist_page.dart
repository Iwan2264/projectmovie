import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projectmovie/controllers/movie_controllers/watchlist_controller.dart';
import 'package:projectmovie/controllers/settings_controllers/settings_controller.dart';
import 'widgets/top_bar.dart';
import 'widgets/watchlist_stats.dart';

class WatchlistPage extends StatelessWidget {
  final WatchlistController controller = Get.put(WatchlistController());
  final SettingsController settingsController = Get.find<SettingsController>();

  WatchlistPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: Column(
          children: [
            Container(
              width: double.infinity,
              height: 50,
              color: Theme.of(context).colorScheme.primary,
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Obx(() => Text(
                    "${settingsController.username.value}'s Watchlist",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.bold,
                    ),
                  )),
            ),
            Obx(() => TopBar(
                  watchTime: controller.watchTime,
                  meanScore: controller.meanScore,
                )),
            Obx(() => WatchlistStats(
                  watched: controller.watched,
                  planToWatch: controller.planToWatch,
                  rewatched: controller.rewatched,
                  dropped: controller.dropped,
                  total: controller.total,
                )),
          ],
        ),
      ),
    );
  }
}