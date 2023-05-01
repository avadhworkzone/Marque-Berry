import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoComponents extends StatefulWidget {
  final String url;
  final bool play;

  const VideoComponents({Key? key, required this.url, required this.play})
      : super(key: key);
  @override
  _VideoComponentsState createState() => _VideoComponentsState();
}

class _VideoComponentsState extends State<VideoComponents> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.url);
    _initializeVideoPlayerFuture = _controller.initialize().then((_) {
      setState(() {});
    });

    if (widget.play) {
      _controller.play();
      _controller.setLooping(false);
    }
  }

  @override
  void didUpdateWidget(VideoComponents oldWidget) {
    if (oldWidget.play != widget.play) {
      if (widget.play) {
        _controller.play();
        _controller.setVolume(1.0);
        _controller.setLooping(true);
      } else {
        _controller.setVolume(0.0);
        _controller.pause();
      }
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeVideoPlayerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return VideoPlayer(_controller);
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
