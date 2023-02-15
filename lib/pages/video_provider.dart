import 'dart:io';

import 'package:flutter/material.dart';
import 'package:photo_gallery/photo_gallery.dart';
import 'package:video_player/video_player.dart';

class VideoProvider extends StatefulWidget {
  final String mediumId;

  const VideoProvider({super.key, required this.mediumId});

  @override
  State<VideoProvider> createState() => _VideoProviderState();
}

class _VideoProviderState extends State<VideoProvider> {
  VideoPlayerController? _controller;
  File? _file;
  bool showOptions = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      initAsync();
    });
    super.initState();
  }

  Future<void> initAsync() async {
    try {
      _file = await PhotoGallery.getFile(mediumId: widget.mediumId);
      _controller = VideoPlayerController.file(_file!);
      _controller?.initialize().then((_) {
        setState(() {});
      });
    } catch (e) {
      // print("Failed : $e");
    }
  }

  void toggleShowOptions() {
    Feedback.forTap(context);
    setState(() {
      showOptions = !showOptions;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _controller == null || !_controller!.value.isInitialized
        ? Container()
        : Stack(
            children: <Widget>[
              GestureDetector(
                onTap: toggleShowOptions,
                child: AspectRatio(
                  aspectRatio: _controller!.value.aspectRatio,
                  child: VideoPlayer(_controller!),
                ),
              ),
              if (showOptions) ...[
                Align(
                  alignment: Alignment.center,
                  child: CircleAvatar(
                    backgroundColor: Theme.of(context)
                        .colorScheme
                        .surfaceVariant
                        .withOpacity(0.5),
                    maxRadius: 25,
                    child: IconButton(
                      alignment: Alignment.center,
                      onPressed: () {
                        setState(() {
                          _controller!.value.isPlaying
                              ? _controller!.pause()
                              : _controller!.play();
                        });
                      },
                      icon: Icon(
                        _controller!.value.isPlaying
                            ? Icons.pause
                            : Icons.play_arrow,
                        size: 30,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: VideoProgressIndicator(
                    _controller!,
                    allowScrubbing: false,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 50),
                    colors: const VideoProgressColors(
                      bufferedColor: Colors.blueGrey,
                      playedColor: Colors.white,
                    ),
                  ),
                )
              ],
            ],
          );
  }
}
