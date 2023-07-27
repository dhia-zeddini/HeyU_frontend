import 'dart:convert';

import 'package:heyu_front/Models/ChatModel.dart';
import 'package:heyu_front/Services/shared_service.dart';
import 'package:heyu_front/config.dart';
import 'package:http/http.dart'as http;


class ChatService{
  static var client=http.Client();

  //login
  static Future<List<ChatModel>?> getUserChats()async{
    var userToken=await SharedService.loginDetails();
    Map<String,String> requestHeaders={
      'Content-Type':'application/json',
      'token':"Bearer ${userToken!.token}"
    };
    var url=Uri.http(Config.apiURL,Config.getUserChatsAPI);
    var response=await client.get(
      url,
      headers: requestHeaders,

    );
    if(response.statusCode==200){
      var data=jsonDecode(response.body);
      print(data);
      return chatsFromJson(data);
    }else{
      return null;
    }
  }
  /*static Future<bool> createChat(LoginRequestModel model)async{
    Map<String,String> requestHeaders={
      'Content-Type':'application/json',
    };
    var url=Uri.http(Config.apiURL,Config.loginAPI);
    var response=await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model.toJson()),
    );
    print(url);
    if(response.statusCode==200){
      await SharedService.setLogindetails(loginResponseJson(response.body));

      return true;
    }else{
      return false;
    }
  }*/

}