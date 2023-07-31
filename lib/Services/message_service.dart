
import 'dart:convert';

import 'package:heyu_front/Models/ChatModel.dart';
import 'package:heyu_front/Models/MessageModel.dart';
import 'package:heyu_front/Services/shared_service.dart';
import 'package:heyu_front/config.dart';
import 'package:http/http.dart'as http;


class MessageServive{
  static var client=http.Client();


  static Future<List<MessageModel>?> getChatMessages(String chatId)async{
    var userToken=await SharedService.loginDetails();
    Map<String,String> requestHeaders={
      'Content-Type':'application/json',
      'token':"Bearer ${userToken!.token}"
    };
    var url=Uri.http(Config.apiURL,Config.chatMessages+chatId);
    var response=await client.get(
      url,
      headers: requestHeaders,

    );
    print(url);
    if(response.statusCode==200){
      var data=jsonDecode(response.body);
      print(data);

      return messagesFromJson(data);
    }else{
      return null;
    }
  }
/*  static Future<bool> createChat(String contact)async{
    var userToken=await SharedService.loginDetails();
    Map<String,String> requestHeaders={
      'Content-Type':'application/json',
      'token':"Bearer ${userToken!.token}"
    };
    Map<String, String> requestBody = {
      "userId": contact,
    };
    var url=Uri.http(Config.apiURL,Config.createChatAPI);
    var response=await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(requestBody),
    );
    print(url);
    print(response.body);
    if(response.statusCode==200){
      return true;
    }else{
      return false;
    }
  }*/

}