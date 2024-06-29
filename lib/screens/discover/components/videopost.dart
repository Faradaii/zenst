import 'dart:async';
import 'package:jumping_dot/jumping_dot.dart';
import 'package:wakelock/wakelock.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:zenst/models/apis/videos.dart';

class VideoPost extends StatefulWidget {
  final Video video;
  final bool isVisible;
  const VideoPost({required this.video, required this.isVisible, super.key});

  @override
  State<VideoPost> createState() => _VideoPostState();
}

class _VideoPostState extends State<VideoPost>
    with AutomaticKeepAliveClientMixin {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    Wakelock.enable();
    _controller =
        VideoPlayerController.networkUrl((Uri.parse(widget.video.videoUrl)));
    _initializeVideoPlayerFuture = _controller.initialize().then((_) {
      _controller.play();
      setState(() {}); 
      Wakelock.enable();
    });
    _controller.setLooping(true);
  }

  @override
  void dispose() {
    _controller.pause();
    _controller.dispose();

    Wakelock.disable();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant VideoPost oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isVisible) {
      _controller.play();
    } else {
      _controller.seekTo(const Duration(milliseconds: 0));
      _controller.pause();
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return FutureBuilder(
      future: _initializeVideoPlayerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            !snapshot.hasError) {
          return GestureDetector(
            onTap: () {
              setState(() {
                if (_controller.value.isPlaying) {
                  _controller.pause();
                  Wakelock.disable();
                } else {
                  _controller.play();
                  Wakelock.enable();
                }
              });
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                FittedBox(
                  child: SizedBox(
                    width: _controller.value.size.width,
                    height: _controller.value.size.height,
                    child: VideoPlayer(_controller),
                  ),
                ),
                AnimatedOpacity(
                  opacity: _controller.value.isPlaying ? 0.0 : 1.0,
                  duration: const Duration(milliseconds: 500),
                  child: Icon(
                    _controller.value.isPlaying
                        ? Icons.pause
                        : Icons.play_arrow,
                    size: 70.0,
                    color: Colors.white.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          );
        } else {
          return Center(child: JumpingDots(color: Colors.lightBlue[300]!));
        }
      },
    );
  }
}
