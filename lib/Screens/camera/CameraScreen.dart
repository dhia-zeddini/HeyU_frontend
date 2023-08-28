import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:heyu_front/Screens/camera/CameraViewPage.dart';
import 'package:heyu_front/Screens/camera/VideoViewPage.dart';
import 'package:path_provider/path_provider.dart';

late List<CameraDescription> cameras;

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key, required this.onImageSend});
  final Function onImageSend;

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _controller;
  bool isRecording = false;
  bool flash = false;
  late FlashMode mode;
  @override
  void initState() {
    super.initState();
    print("initialize cam");
    initializeCamera();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  Future<void> initializeCamera() async {
    if (!mounted){
      return;
    }
    _controller = CameraController(
      cameras[0],
      ResolutionPreset.high,
    );

    try {
      await _controller.initialize();
      mode = _controller.value.flashMode;
    } catch (e) {
      print('Error initializing camera: $e');
    }
    if (!mounted) return;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (!_controller.value.isInitialized) {
      return Container();
    }

    return Scaffold(
      body: Stack(
        children: [
          FutureBuilder(
            future: _controller.initialize(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator(); // or a loading indicator
              } else if (snapshot.hasError) {
                return Text('Error initializing camera: ${snapshot.error}');
              } else {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: CameraPreview(_controller),
                );
              }
            },
          ),
          Positioned(
            bottom: 0.0,
            child: Container(
              color: Colors.black,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: /*Icon(
                          mode == FlashMode.auto
                              ? Icons.flash_auto
                              : mode == FlashMode.always
                                  ? Icons.flash_on
                                  : Icons.flash_off,
                          color: Colors.white,
                          size: 28,
                        ),*/
                            Icon(
                          flash ? Icons.flash_on : Icons.flash_off,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                      GestureDetector(
                        onLongPress: () async {
                          /* if (!isRecording) {
                            await _controller.startVideoRecording();
                            setState(() {
                              isRecording = true;
                            });
                          }*/
                        },
                        onLongPressUp: () async {
                          /*if (isRecording) {
                            XFile video =
                                await _controller.stopVideoRecording();
                            setState(() {
                              isRecording = false;
                            });
                            final Directory appDirectory =
                                await getTemporaryDirectory();
                            final String fileName = '${DateTime.now()}.mp4';
                            final String videoPath =
                                '${appDirectory.path}/$fileName';
                            await video.saveTo(videoPath);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (builder) =>
                                      VideoViewPage(path: videoPath)),
                            );
                          }*/
                        },
                        onTap: () {
                          if (!isRecording) {
                            takePhoto(context);
                          }
                        },
                        child: isRecording
                            ? const Icon(
                                Icons.radio_button_on,
                                color: Colors.red,
                                size: 80,
                              )
                            : const Icon(
                                Icons.panorama_fish_eye,
                                color: Colors.white,
                                size: 70,
                              ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.flip_camera_ios,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  const Text(
                    "Hold for video ,Tap for photo",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void takePhoto(BuildContext context) async {
    final Directory appDirectory = await getTemporaryDirectory();
    final String fileName = '${DateTime.now()}.png';
    final String imagePath = '${appDirectory.path}/$fileName';
    //final path= ((await getTemporaryDirectory()).path,"${DateTime.now()}.png");
    XFile picture = await _controller.takePicture();
    await picture.saveTo(imagePath);
    if (mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (builder) => CameraViewPage(
                  path: imagePath,
                  onImageSend: widget.onImageSend,
                )),
      );
    }
  }

  void stopVideRecording() async {
    final Directory appDirectory = await getTemporaryDirectory();
    final String fileName = '${DateTime.now()}.mp4';
    final String videoPath = '${appDirectory.path}/$fileName';
    XFile video = await _controller.stopVideoRecording();
    await video.saveTo(videoPath);
    setState(() {
      isRecording = false;
    });
    if (mounted) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (builder) => VideoViewPage(path: videoPath)));
    }
  }

  Future<void> _startVideoRecording() async {
    if (_controller.value.isRecordingVideo) return;

    try {
      await _controller.startVideoRecording();
      setState(() {
        isRecording = true;
      });
    } catch (e) {
      print("Error starting video recording: $e");
    }
  }

  Future<void> _stopVideoRecording() async {
    if (!_controller.value.isRecordingVideo) return;

    try {
      XFile videoFile = await _controller.stopVideoRecording();
      setState(() {
        isRecording = false;
      });

      final Directory appDirectory = await getTemporaryDirectory();
      final String fileName = '${DateTime.now()}.mp4';
      final String videoPath = '${appDirectory.path}/$fileName';
      await videoFile.saveTo(videoPath);
      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => VideoViewPage(path: videoPath)),
        );
      }
    } catch (e) {
      print("Error stopping video recording: $e");
    }
  }

  void toggleFlash() async {
    if (!_controller.value.isInitialized) {
      return;
    }

    if (_controller.value.flashMode == FlashMode.off) {
      await _controller.setFlashMode(FlashMode.auto);
    } else if (_controller.value.flashMode == FlashMode.auto) {
      await _controller.setFlashMode(FlashMode.always);
    } else if (_controller.value.flashMode == FlashMode.always) {
      await _controller.setFlashMode(FlashMode.off);
    }

    setState(() {
      flash = _controller.value.flashMode != FlashMode.off;
      mode = _controller.value.flashMode;
    });
  }
}
