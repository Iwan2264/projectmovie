import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'package:projectmovie/controllers/movie_controllers/movie_controller.dart';

class MovieTrailerInlineWidget extends StatefulWidget {
  final int movieId;
  const MovieTrailerInlineWidget({super.key, required this.movieId});

  @override
  State<MovieTrailerInlineWidget> createState() => _MovieTrailerInlineWidgetState();
}

class _MovieTrailerInlineWidgetState extends State<MovieTrailerInlineWidget> {
  late Future<String?> _trailerFuture;
  YoutubePlayerController? _ytController;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    final controller = Get.find<MovieController>();
    _trailerFuture = controller.fetchYoutubeTrailerKey(widget.movieId);
  }

  @override
  void dispose() {
    _ytController?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return FutureBuilder<String?>(
      future: _trailerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox(
            height: 180,
            child: Center(child: CircularProgressIndicator()),
          );
        }

        if (!snapshot.hasData || snapshot.data == null) {
          return Container(
            height: 180,
            margin: const EdgeInsets.symmetric(horizontal: 4),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: colorScheme.surfaceContainerHighest,
            ),
            child: Center(
              child: Text(
                "Trailer not available",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          );
        }

        final videoKey = snapshot.data!;

        if (_isPlaying) {
          _ytController ??= YoutubePlayerController.fromVideoId(
            videoId: videoKey,
            autoPlay: true,
          );

          return ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: YoutubePlayer(
              controller: _ytController!,
              aspectRatio: 16 / 9,
            ),
          );
        }

        return InkWell(
          onTap: () {
            setState(() => _isPlaying = true);
          },
          borderRadius: BorderRadius.circular(12),
          child: Container(
            height: 180,
            margin: const EdgeInsets.symmetric(horizontal: 4),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: colorScheme.surfaceContainerHighest,
            ),
            child: Center(
              child: Icon(
                Icons.play_circle_fill,
                size: 50,
                color: colorScheme.primary,
              ),
            ),
          ),
        );
      },
    );
  }
}