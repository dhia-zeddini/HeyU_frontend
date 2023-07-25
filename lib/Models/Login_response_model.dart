
import 'dart:convert';

LoginResponseModel loginResponseModel(String str)=>
    LoginResponseModel.fromJson(json.decode(str));
class LoginResponseModel {
  late bool status;
  late String token;

  LoginResponseModel({required this.status, required this.token});

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['token'] = token;
    return data;
  }
}