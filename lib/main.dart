import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:heyu_front/Screens/HomeScreen.dart';
import 'package:heyu_front/Screens/auth/LandingPage.dart';
import 'package:heyu_front/Screens/authentcation/LoginScreen.dart';
import 'package:heyu_front/Screens/authentcation/RegistrationScreen.dart';
import 'package:heyu_front/Screens/chat/chatsScreen.dart';
import 'package:heyu_front/Services/shared_service.dart';

import 'Screens/CameraScreen.dart';
Widget defaultHome=const LandingPage();

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  bool result=await SharedService.isLoggedIn();
  if(result){
    defaultHome=const HomeScreen();
  }
  SecurityContext.defaultContext.setAlpnProtocols(['TLSv1.2'], true);
  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HeyU',
      home: defaultHome,
      routes: {

        '/login':(context)=>const LoginScreen(),
        '/register':(context)=>const RegistrationScreen(),
        '/chats':(context)=>const ChatsScreen(),
      },
    );

  }
}
