import 'package:flutter/material.dart';
import 'package:flutter_to_airplay/flutter_to_airplay.dart';
import 'package:video_player/video_player.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
        Uri.parse(
          'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
        ).toString(),
      )
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
      });

    _controller.addListener(() {
      if (_controller.value.hasError) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Error'),
              content: Text(_controller.value.errorDescription ?? ''),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: double.infinity,
                height: 300,
                child: FlutterAVPlayerView(
                  // filePath: 'assets/videos/butterfly.mp4',
                  urlString:
                      'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
                ),
              ),
              // Stack(
              //   alignment: Alignment.bottomCenter,
              //   children: [
              //     Center(
              //       child:
              //           _controller.value.isInitialized
              //               ? AspectRatio(
              //                 aspectRatio: _controller.value.aspectRatio,
              //                 child: VideoPlayer(_controller),
              //               )
              //               : CircularProgressIndicator(),
              //     ),
              //   ],
              // ),
              const AirPlayRoutePickerView(
                tintColor: Colors.green,
                activeTintColor: Colors.transparent,
                backgroundColor: Colors.transparent,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
