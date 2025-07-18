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
        return Builder(
          builder: (context) => ElevatedButton.icon(
            icon: Icon(_statusIcon(status ?? WatchStatus.planToWatch)),
            label: Text(_statusLabel(status ?? WatchStatus.planToWatch)),
            onPressed: () async {
              final button = context.findRenderObject() as RenderBox;
              final buttonPosition = button.localToGlobal(Offset.zero);
              final screenHeight = MediaQuery.of(context).size.height;
              final spaceBelow = screenHeight - buttonPosition.dy - button.size.height;

              RelativeRect position;
              if (spaceBelow < 220) {
                position = RelativeRect.fromLTRB(
                  buttonPosition.dx,
                  buttonPosition.dy - 200,
                  buttonPosition.dx + button.size.width,
                  buttonPosition.dy
                );
              } else {
                position = RelativeRect.fromLTRB(
                  buttonPosition.dx,
                  buttonPosition.dy + button.size.height,
                  buttonPosition.dx + button.size.width,
                  buttonPosition.dy + button.size.height + 200
                );
              }

              final selected = await showMenu<WatchStatus?>(
                context: context,
                position: position,
                items: [
                  PopupMenuItem(
                    value: WatchStatus.planToWatch,
                    child: const Text('Plan to Watch'),
                  ),
                  PopupMenuItem(
                    value: WatchStatus.watched,
                    child: const Text('Watched'),
                  ),
                  PopupMenuItem(
                    value: WatchStatus.rewatched,
                    child: const Text('Rewatched'),
                  ),
                  PopupMenuItem(
                    value: WatchStatus.dropped,
                    child: const Text('Dropped'),
                  ),
                  const PopupMenuDivider(),
                  PopupMenuItem<WatchStatus?>(
                    value: WatchStatus.dropped,
                    child: const Text(
                      'Remove!',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ],
              );
              if (selected == WatchStatus.dropped) {
                watchlistController.removeFromWatchlist(movie);
              } else if (selected != null) {
                watchlistController.setStatus(movie, selected);
              }
            },
          ),
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