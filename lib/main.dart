import 'package:flutter/material.dart';
import 'package:heyu_front/Screens/auth/LandingPage.dart';
import 'package:heyu_front/Screens/authentcation/LoginScreen.dart';
import 'package:heyu_front/Screens/authentcation/RegistrationScreen.dart';
import 'package:heyu_front/Screens/chat/chatsScreen.dart';

void main() {
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
      home: LandingPage(),
      routes: {

        '/login':(context)=>const LoginScreen(),
        '/register':(context)=>const RegistrationScreen(),
        '/chats':(context)=>const ChatsScreen(),
      },
    );

  }
}
