import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:heyu_front/Screens/HomeScreen.dart';
import 'package:heyu_front/Screens/auth/LandingPage.dart';
import 'package:heyu_front/Screens/authentcation/LoginScreen.dart';
import 'package:heyu_front/Screens/authentcation/RegistrationScreen.dart';
import 'package:heyu_front/Screens/chat/chatsScreen.dart';
import 'package:heyu_front/Screens/chat/indivChatScreen.dart';
import 'package:heyu_front/Services/shared_service.dart';
import 'package:path/path.dart';

import 'Screens/camera/CameraScreen.dart';
bool connected = false;
Widget defaultHome(context)=>connected?const HomeScreen():const LandingPage() ;

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  connected=await SharedService.isLoggedIn();
  SecurityContext.defaultContext.setAlpnProtocols(['TLSv1.2'], true);
  runApp(const MyApp());

}
Map<String,dynamic>routes={
  '/':defaultHome,
  '/home':(context)=> const HomeScreen(),
  '/login':(context)=>const LoginScreen(),
  '/register':(context)=>const RegistrationScreen(),
  '/chats':(context)=>const ChatsScreen(),
  "/indivChat":(context)=>IndivChatScreen(chatModel: context['chatModel'],title: context['title'],avatar: context['avatar'],)
};
class MyApp extends StatelessWidget {
  const MyApp({super.key});


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'HeyU',
        /*home: defaultHome,
      onGenerateInitialRoutes: {

        '/':defaultHome,
        '/login':(context)=>const LoginScreen(),
        '/register':(context)=>const RegistrationScreen(),
        '/chats':(context)=>const ChatsScreen(),
        "/indivChat":(context)=>IndivChatScreen(chatModel: context['chatModels'])
      },
    );*/
        initialRoute: '/',
        onGenerateRoute: (settings) {
          return MaterialPageRoute(builder: (context) {
            return GestureDetector(
              onTap: () {
                FocusScopeNode currentFocus = FocusScope.of(context);

                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.unfocus();
                }
              },
              child: routes[settings.name]!(settings.arguments != null
                  ? settings.arguments as Map<String, dynamic>
                  : null),
            );
          });
        });
  }
}



