import 'dart:convert';


import 'package:api_cache_manager/api_cache_manager.dart';
import 'package:api_cache_manager/models/cache_db_model.dart';
import 'package:date_time_format/date_time_format.dart';
import 'package:flutter/material.dart';
import 'package:heyu_front/Models/Login_response_model.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';

import '../Screens/chat/customAvatar.dart';
import '../config.dart';


class SharedService {
  static ZegoUIKitPrebuiltCallController? callController;
  static Future<bool> isLoggedIn() async {
    return await APICacheManager().isAPICacheKeyExist("login_details");
  }

  static Future<LoginResponseModel?> loginDetails() async {
    if (await isLoggedIn()) {
      var cacheData = await APICacheManager().getCacheData("login_details");
      /*print(loginResponseJson(cacheData.syncData).token);*/
      return loginResponseJson(cacheData.syncData);
    }
    return null;
  }

  static Future<void> setLogindetails(LoginResponseModel model) async {
    APICacheDBModel cacheDBModel = APICacheDBModel(
        key: "login_details", syncData: jsonEncode(model.toJson()));
    await APICacheManager().addCacheData(cacheDBModel);
  }

  static Future<void> logout(BuildContext context) async{
    await APICacheManager().deleteCache("login_details");
    onUserLogout();
    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
  }

  static Future<Map<String, dynamic>> decodedToken() async {
    var userToken = await SharedService.loginDetails();
    return JwtDecoder.decode(userToken!.token);
  }

  static String msgTime(DateTime messageTime) {
    DateTime now = DateTime.now();

    if (now.year == messageTime.year &&
        now.month == messageTime.month &&
        now.day == messageTime.day) {
      return messageTime.format('H:i');
    }else if(now.year==messageTime.year&&
        now.month==messageTime.month&&
        now.day-messageTime.day==1){
      return "Yesterday";
    }else{
      return messageTime.format("d/m/Y");
    }
  }
  static Future<String> userId() async {
    Map<String, dynamic> decodedToken = await SharedService.decodedToken();
    return decodedToken['_id'].toString();
  }
  static Future<bool> messageSenderTest(String sender)async{
    String userId=await SharedService.userId();
    return sender==userId;
  }
  static void onUserLogin()async {
    callController ??= ZegoUIKitPrebuiltCallController();
    var user= await userId();
    /// 4/5. initialized ZegoUIKitPrebuiltCallInvitationService when account is logged in or re-logged in
    ZegoUIKitPrebuiltCallInvitationService().init(
      appID: Config.zegoAppId /*input your AppID*/,
      appSign: Config.zegoAppSignIn /*input your AppSign*/,
      userID: user,
      userName: user,
      notifyWhenAppRunningInBackgroundOrQuit: true,
      androidNotificationConfig: ZegoAndroidNotificationConfig(
        channelID: "ZegoUIKit",
        channelName: "Call Notifications",
        sound: "notification",
        callIDVisibility: true,
      ),
      iOSNotificationConfig: ZegoIOSNotificationConfig(
        isSandboxEnvironment: true,
        systemCallingIconName: 'CallKitIcon',
      ),
      plugins: [ZegoUIKitSignalingPlugin()],
      controller: callController,
      requireConfig: (ZegoCallInvitationData data) {
        final config = (data.invitees.length > 1)
            ? ZegoCallType.videoCall == data.type
            ? ZegoUIKitPrebuiltCallConfig.groupVideoCall()
            : ZegoUIKitPrebuiltCallConfig.groupVoiceCall()
            : ZegoCallType.videoCall == data.type
            ? ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall()
            : ZegoUIKitPrebuiltCallConfig.oneOnOneVoiceCall();

        config.avatarBuilder = customAvatarBuilder;

        /// support minimizing, show minimizing button
        config.topMenuBarConfig.isVisible = true;
        config.topMenuBarConfig.buttons
            .insert(1, ZegoMenuBarButtonName.minimizingButton);

        return config;
      },
    );
  }
  static void onUserLogout() {
    callController = null;

    /// 5/5. de-initialization ZegoUIKitPrebuiltCallInvitationService when account is logged out
    ZegoUIKitPrebuiltCallInvitationService().uninit();
  }

}
