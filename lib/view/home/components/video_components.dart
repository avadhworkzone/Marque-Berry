import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:socialv/commanWidget/loader.dart';
import 'package:socialv/utils/color_utils.dart';
import 'package:video_player/video_player.dart';

class InViewVideoComponents extends StatefulWidget {
  final String url;
  final bool play;

  const InViewVideoComponents({Key? key, required this.url, required this.play})
      : super(key: key);
  @override
  _InViewVideoComponentsState createState() => _InViewVideoComponentsState();
}

class _InViewVideoComponentsState extends State<InViewVideoComponents> {
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
  void didUpdateWidget(InViewVideoComponents oldWidget) {
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

class FileVideoPlayer extends StatefulWidget {
  final String url;
  final bool fileVideo;

  FileVideoPlayer({
    Key? key,
    required this.url,
    this.fileVideo = false,
  }) : super(key: key);

  @override
  State<FileVideoPlayer> createState() => _FileVideoPlayerState();
}

class _FileVideoPlayerState extends State<FileVideoPlayer> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();

    if (widget.fileVideo == true) {
      _controller = VideoPlayerController.file(File(widget.url));
    } else {
      _controller = VideoPlayerController.network(widget.url);
    }

    _initializeVideoPlayerFuture = _controller.initialize().then((_) {
      _controller.play();
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
    return FutureBuilder(
      future: _initializeVideoPlayerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Stack(
            children: [
              VideoPlayer(_controller),
              Center(
                child: InkWell(
                  onTap: () {
                    setState(() {
                      _controller.value.isPlaying
                          ? _controller.pause()
                          : _controller.play();
                    });
                  },
                  child: Icon(
                    _controller.value.isPlaying
                        ? Icons.pause_circle
                        : Icons.play_circle,
                    color: ColorUtils.grey,
                    size: 15.w,
                  ),
                ),
              )
            ],
          );
        } else {
          return Center(child: Loader());
        }
      },
    );
  }
}
