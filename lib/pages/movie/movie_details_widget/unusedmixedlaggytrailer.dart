//Not Using This Code
// This code is not used in the current implementation but is kept for reference.

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projectmovie/controllers/movie_controllers/movie_controller.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart' as iframe;
import 'package:youtube_player_flutter/youtube_player_flutter.dart' as flutter;

class MovieTrailerInlineWidget extends StatefulWidget {
  final int movieId;
  const MovieTrailerInlineWidget({super.key, required this.movieId});

  @override
  State<MovieTrailerInlineWidget> createState() => _MovieTrailerInlineWidgetState();
}

class _MovieTrailerInlineWidgetState extends State<MovieTrailerInlineWidget> {
  late Future<String?> _trailerFuture;
  bool _isPlaying = false;
  bool _useFallback = false;

  iframe.YoutubePlayerController? _ytIframeController;
  flutter.YoutubePlayerController? _ytFlutterController;

  @override
  void initState() {
    super.initState();
    final controller = Get.find<MovieController>();
    _trailerFuture = controller.fetchYoutubeTrailerKey(widget.movieId);
  }

  @override
  void dispose() {
    _ytIframeController?.close();
    _ytFlutterController?.dispose();
    super.dispose();
  }

  Widget buildIframePlayer(String videoId) {
    _ytIframeController = iframe.YoutubePlayerController.fromVideoId(
      videoId: videoId,
      autoPlay: true,
    );

    return iframe.YoutubePlayer(
      controller: _ytIframeController!,
      aspectRatio: 16 / 9,
    );
  }

  Widget buildFlutterPlayer(String videoId) {
    _ytFlutterController = flutter.YoutubePlayerController(
      initialVideoId: videoId,
      flags: const flutter.YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
        enableCaption: true,
      ),
    );

    return flutter.YoutubePlayer(
      controller: _ytFlutterController!,
      showVideoProgressIndicator: true,
      progressIndicatorColor: Theme.of(context).colorScheme.primary,
    );
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
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
            ),
            child: const Center(child: Text("Trailer not available")),
          );
        }

        final videoKey = snapshot.data!;

        if (_isPlaying) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: _useFallback
                ? buildFlutterPlayer(videoKey)
                : buildIframePlayer(videoKey),
          );
        }

        return InkWell(
          onTap: () {
            setState(() => _isPlaying = true);

            // fallback trigger after 3 seconds if iframe fails
            Future.delayed(const Duration(seconds: 3), () {
              if (mounted && _ytIframeController?.metadata.title == '') {
                setState(() => _useFallback = true);
              }
            });
          },
          child: Container(
            height: 180,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.black,
            ),
            child: Center(
              child: Icon(
                Icons.play_circle_fill,
                size: 50,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ),
        );
      },
    );
  }
}
