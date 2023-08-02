import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

late List<CameraDescription> cameras;

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _controller;

  @override
  void initState() {
    super.initState();
    initializeCamera();
  }

  @override
  void dispose() {
    //_controller.dispose();
    super.dispose();
  }

  Future<void> initializeCamera() async {
    // Get available cameras
    //cameras = await availableCameras();

    _controller = CameraController(
      cameras[0],
      ResolutionPreset.high,
    );

    try {
      await _controller.initialize();
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
                return CameraPreview(_controller);
              }
            },
          ),
        ],
      ),
    );
  }
}
