import 'dart:convert';

import 'package:heyu_front/Models/Login_request_model.dart';
import 'package:heyu_front/Models/Login_response_model.dart';
import 'package:heyu_front/Models/Register_request_model.dart';
import 'package:heyu_front/Models/Register_response_model.dart';
import 'package:heyu_front/Services/shared_service.dart';
import 'package:heyu_front/config.dart';
import 'package:http/http.dart'as http;


class AuthService{
  static var client=http.Client();

  //login
  static Future<bool> login(LoginRequestModel model)async{
    Map<String,String> requestHeaders={
      'Content-Type':'application/json',
    };
    var url=Uri.http(Config.apiURL,Config.loginAPI);
    var response=await client.post(
        url,
      headers: requestHeaders,
      body: jsonEncode(model.toJson()),
    );
    /*print(url);*/
    if(response.statusCode==200){
      await SharedService.setLogindetails(loginResponseJson(response.body));

      return true;
    }else{
      return false;
    }
  }

  //registration
  static Future<RegisterResponseModel> register(RegisterRequestModel model)async{
    Map<String,String> requestHeaders={
      'Content-Type':'application/json',
    };
    var url=Uri.http(Config.apiURL,Config.registerAPI);
    var response=await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model.toJson()),
    );
    return registerResponseJson(response.body);
  }
}