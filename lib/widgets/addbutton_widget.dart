import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projectmovie/controllers/movie_controllers/watchlist_controller.dart';
import 'package:projectmovie/models/movie.dart';
import 'package:projectmovie/models/watchlist_entry.dart';

class AddToListButton extends StatelessWidget {
  final Movie movie;

  const AddToListButton({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    final watchlistController = Get.find<WatchlistController>();
    return Obx(() {
      final isInList = watchlistController.isInWatchlist(movie);
      final status = watchlistController.getStatus(movie);

      if (!isInList) {
        return ElevatedButton.icon(
          icon: const Icon(Icons.add),
          label: const Text('Add to List'),
          onPressed: () => watchlistController.addToWatchlist(movie),
        );
      } else {
        return PopupMenuButton<WatchStatus>(
          child: ElevatedButton.icon(
            icon: Icon(_statusIcon(status!)),
            label: Text(_statusLabel(status)),
            onPressed: null,
          ),
          onSelected: (newStatus) {
            watchlistController.setStatus(movie, newStatus);
          },
          itemBuilder: (context) => <PopupMenuEntry<WatchStatus>>[
            PopupMenuItem(
              value: WatchStatus.planToWatch,
              child: Text('Plan to Watch'),
            ),
            PopupMenuItem(
              value: WatchStatus.watched,
              child: Text('Watched'),
            ),
            PopupMenuItem(
              value: WatchStatus.rewatched,
              child: Text('Rewatched'),
            ),
            PopupMenuItem(
              value: WatchStatus.dropped,
              child: Text('Dropped'),
            ),
            PopupMenuItem(
              child: Text(
                'Remove from List',
                style: TextStyle(color: Colors.red),
              ),
              onTap: () => watchlistController.removeFromWatchlist(movie),
            ),
          ],
        );
      }
    });
  }

  String _statusLabel(WatchStatus status) {
    switch (status) {
      case WatchStatus.planToWatch:
        return "Plan to Watch";
      case WatchStatus.watched:
        return "Watched";
      case WatchStatus.rewatched:
        return "Rewatched";
      case WatchStatus.dropped:
        return "Dropped";
    }
  }

  IconData _statusIcon(WatchStatus status) {
    switch (status) {
      case WatchStatus.planToWatch:
        return Icons.bookmark_add_outlined;
      case WatchStatus.watched:
        return Icons.visibility_rounded;
      case WatchStatus.rewatched:
        return Icons.repeat;
      case WatchStatus.dropped:
        return Icons.remove_circle_outline;
    }
  }
}