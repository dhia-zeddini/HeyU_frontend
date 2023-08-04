import 'dart:convert';

import 'package:heyu_front/Models/ChatModel.dart';
import 'package:heyu_front/Models/UserModel.dart';
import 'package:heyu_front/Services/shared_service.dart';
import 'package:heyu_front/config.dart';
import 'package:http/http.dart'as http;


class UserService{
  static var client=http.Client();


  static Future<List<UserModel>?> getUserContacts()async{
    var userToken=await SharedService.loginDetails();
    Map<String,String> requestHeaders={
      'Content-Type':'application/json',
      'token':"Bearer ${userToken!.token}"
    };
    var url=Uri.http(Config.apiURL,Config.getUserContacts);
    var response=await client.get(
      url,
      headers: requestHeaders,

    );
    if(response.statusCode==200){
      var data=jsonDecode(response.body);
      print(data);
      return usersFromJson(data);
    }else{
      return null;
    }
  }


}