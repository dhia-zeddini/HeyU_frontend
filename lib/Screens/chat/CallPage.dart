import 'package:flutter/material.dart';
import 'package:heyu_front/Models/ChatModel.dart';
import 'package:heyu_front/Services/shared_service.dart';
import 'package:heyu_front/config.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class CallPage extends StatelessWidget {
  const CallPage({super.key,required this.chatModel});
   final ChatModel chatModel;


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FutureBuilder<String>(
        future: userConnected(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return ZegoUIKitPrebuiltCall(
              appID: Config.zegoAppId,
              appSign: Config.zegoAppSignIn,
              userID: snapshot.data ?? '',
              callID: chatModel.chatId,
              userName: chatModel.users[1].userName,
              config: ZegoUIKitPrebuiltCallConfig.oneOnOneVoiceCall()..onOnlySelfInRoom=(context){
                Navigator.of(context).pop();
              }
            );
          } else {
            // You can show a loading indicator here while waiting for userConnected() to complete.
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }

  Future<String> userConnected() async {
    return await SharedService.userId();
  }
}