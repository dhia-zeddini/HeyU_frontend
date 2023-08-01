
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
    if(response.statusCode==200){
      var data=jsonDecode(response.body);
      return messagesFromJson(data);
    }else{
      return null;
    }
  }
  static Future<List<dynamic>> sendMessage(String content,String reciver,String chat)async{
    var userToken=await SharedService.loginDetails();
    Map<String,String> requestHeaders={
      'Content-Type':'application/json',
      'token':"Bearer ${userToken!.token}"
    };
    Map<String, String> requestBody = {
      "content":content,
      "chatId":chat,
      "receiverId":reciver
    };
    var url=Uri.http(Config.apiURL,Config.chatMessages);
    var response=await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(requestBody),
    );
    /*print(url);
    print(response.body);*/
    if(response.statusCode==200){
      MessageModel msg=MessageModel.fromJson(jsonDecode(response.body));
      print(msg);

      var messsageMap=msg.toJson();
      return [true,msg,messsageMap];
    }else{
      return [false];
    }
  }

}