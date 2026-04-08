import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ServiceVideoPlayer extends StatefulWidget {
  final String url;

  const ServiceVideoPlayer({super.key, required this.url});

  @override
  State<ServiceVideoPlayer> createState() => _ServiceVideoPlayerState();
}

class _ServiceVideoPlayerState extends State<ServiceVideoPlayer> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.url))
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_controller.value.isInitialized) {
      return const Center(child: CircularProgressIndicator());
    }

    return AspectRatio(
      aspectRatio: _controller.value.aspectRatio,
      child: Stack(
        alignment: Alignment.center,
        children: [
          VideoPlayer(_controller),

          IconButton(
            iconSize: 60,
            color: Colors.white,
            icon: Icon(
              _controller.value.isPlaying
                  ? Icons.pause_circle
                  : Icons.play_circle,
            ),
            onPressed: () {
              setState(() {
                _controller.value.isPlaying
                    ? _controller.pause()
                    : _controller.play();
              });
            },
          ),
        ],
      ),
    );
  }
}

class YouTubeVideoWidget extends StatefulWidget {
  final String url;

  const YouTubeVideoWidget({super.key, required this.url});

  @override
  State<YouTubeVideoWidget> createState() => _YouTubeVideoWidgetState();
}

class _YouTubeVideoWidgetState extends State<YouTubeVideoWidget> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();

    final videoId = YoutubePlayer.convertUrlToId(widget.url)!;

    _controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(autoPlay: false, mute: false),
    );
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayer(controller: _controller);
  }
}

class UniversalVideoPlayer extends StatelessWidget {
  final String url;

  const UniversalVideoPlayer({super.key, required this.url});

  bool isYoutube(String url) {
    return url.contains("youtube.com") || url.contains("youtu.be");
  }

  bool isNetworkVideo(String url) {
    return url.endsWith(".mp4") ||
        url.endsWith(".m3u8") ||
        url.contains("video/upload");
  }

  @override
  Widget build(BuildContext context) {
    // 🎬 YOUTUBE
    if (isYoutube(url)) {
      final videoId = YoutubePlayer.convertUrlToId(url);

      if (videoId == null) {
        return const _ErrorWidget();
      }

      return YoutubePlayer(
        controller: YoutubePlayerController(
          initialVideoId: videoId,
          flags: const YoutubePlayerFlags(autoPlay: false, mute: false),
        ),
        showVideoProgressIndicator: true,
      );
    }

    // 📹 NORMAL VIDEO
    if (isNetworkVideo(url)) {
      return ServiceVideoPlayer(url: url);
    }

    // ❌ FALLBACK
    return const _ErrorWidget();
  }
}

// ❌ ERROR UI (premium feel)
class _ErrorWidget extends StatelessWidget {
  const _ErrorWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      color: Colors.black12,
      child: const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline, size: 40, color: Colors.grey),
            SizedBox(height: 8),
            Text("Video not supported", style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
