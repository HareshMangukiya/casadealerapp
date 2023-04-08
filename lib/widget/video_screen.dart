import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';

import 'package:path_provider/path_provider.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerPage extends StatefulWidget {
  final String videoFilePath;

  VideoPlayerPage({required this.videoFilePath});

  @override
  _VideoPlayerPageState createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  late VideoPlayerController _videoPlayerController;
  Timer? _hidePlayButtonTimer;
  bool _showPlayButton = true;

  @override
  void initState() {
    super.initState();

    _videoPlayerController = VideoPlayerController.network(widget.videoFilePath)
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    super.dispose();
    _videoPlayerController.dispose();
    _hidePlayButtonTimer?.cancel();
  }

  void _startHidePlayButtonTimer() {
    _hidePlayButtonTimer?.cancel();
    _hidePlayButtonTimer = Timer(Duration(seconds: 3), () {
      setState(() {
        _showPlayButton = false;
      });
    });
  }

  void _showPlayButtonAgain() {
    _hidePlayButtonTimer?.cancel();
    setState(() {
      _showPlayButton = true;
    });
    _startHidePlayButtonTimer();
  }

  bool _downloading = false;

  void _downloadVideo(String videoFilePath) async {
    String videoUrl = widget.videoFilePath;
    final appDocDir = await getExternalStorageDirectory();
    final directoryPath = '${appDocDir!.path}/Download';
    await Directory(directoryPath).create(recursive: true);
    final filePath = '$directoryPath/${DateTime.now().millisecondsSinceEpoch}.mp4';

    setState(() {
      _downloading = true;
    });

    await Dio().download(videoUrl, filePath);
    await GallerySaver.saveVideo(filePath);

    setState(() {
      _downloading = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Video saved to gallery')),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video Player'),
        backgroundColor: Color(0xff333389),
        actions: [

          IconButton(
            icon: Icon(Icons.download),
            onPressed: () => _downloadVideo(widget.videoFilePath),
          ),
        ],

      ),
      body: GestureDetector(
        onTap: _showPlayButtonAgain,
        child: Stack(
          children: [


            Center(
              child: _videoPlayerController.value.isInitialized
                  ? AspectRatio(
                aspectRatio: _videoPlayerController.value.aspectRatio,
                child: VideoPlayer(_videoPlayerController),
              )
                  : CircularProgressIndicator(),
            ),
            if (_showPlayButton)
              Positioned(
                top: 40.h,
                left: 42.w,

                child: IconButton(

                  onPressed: () {
                    _showPlayButtonAgain();
                    setState(() {
                      if (_videoPlayerController.value.isPlaying) {
                        _videoPlayerController.pause();
                      } else {
                        _videoPlayerController.play();
                      }
                    }


                    );
                  },
                  icon: Icon(
                    _videoPlayerController.value.isPlaying
                        ? Icons.pause
                        : Icons.play_arrow,
                    size: 5.h,
                  ),
                ),

              ),
            if (_downloading)
              Positioned(
                top: 41.h,
                left: 40.w,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: CircularProgressIndicator(),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
