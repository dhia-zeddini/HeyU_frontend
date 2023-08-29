import 'dart:convert';

import 'package:heyu_front/Models/Login_request_model.dart';
import 'package:heyu_front/Models/Login_response_model.dart';
import 'package:heyu_front/Models/Register_request_model.dart';
import 'package:heyu_front/Models/Register_response_model.dart';
import 'package:heyu_front/Services/shared_service.dart';
import 'package:heyu_front/config.dart';
import 'package:http/http.dart'as http;
import 'package:http_parser/http_parser.dart';


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
  static Future<RegisterResponseModel> register(RegisterRequestModel model,String path)async{
    Map<String,String> requestHeaders={
      'Content-Type':'application/json',
    };
    var url=Uri.http(Config.apiURL,Config.registerAPI);
    var request = http.MultipartRequest('POST', url);
    request.headers.addAll(requestHeaders);
    request.fields['firstName']=model.firstName;
    request.fields['lastName']=model.lastName;
    request.fields['userName']=model.userName;
    request.fields['email']=model.email;
    request.fields['phoneNumber']=model.phoneNumber;
    request.fields['password']=model.password;
    request.fields['about']=model.about;


    if (path!="") {
      var image = await http.MultipartFile.fromPath('img', path,
          contentType: MediaType('image', 'jpeg')); //
      request.files.add(image);
    }
    var response = await http.Response.fromStream(await request.send());
    print(request.fields);
    return registerResponseJson(response.body);
  }
}
