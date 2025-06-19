import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'package:projectmovie/controllers/movie_controller.dart';

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
              color: Theme.of(context).colorScheme.surface,
            ),
            child: const Center(child: Text("Trailer not available")),
          );
        }

        final videoKey = snapshot.data!;

        if (_isPlaying) {
          _ytController ??= YoutubePlayerController.fromVideoId(
            videoId: videoKey,
            autoPlay: true,
            //showControls: true,
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
          child: Container(
            height: 180,
            margin: const EdgeInsets.symmetric(horizontal: 4),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.black,
            ),
            child: const Center(
              child: Icon(Icons.play_circle_fill, size: 50, color: Colors.white),
            ),
          ),
        );
      },
    );
  }
}
