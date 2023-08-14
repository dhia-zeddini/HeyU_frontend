import 'package:flutter/material.dart';
import 'package:heyu_front/Screens/camera/CameraScreen.dart';


class CameraPage extends StatelessWidget {
  const CameraPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CameraScreen(onImageSend: (){},);
  }
}
