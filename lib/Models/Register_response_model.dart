import 'dart:convert';

RegisterResponseModel registerResponseJson(String str)=>
    RegisterResponseModel.fromJson(json.decode(str));

class RegisterResponseModel {
  late bool status;
  late String message;


  RegisterResponseModel({required this.status,  required this.message});

  RegisterResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if(json['success']) {
      message = json['success'];
    }else{
      message= json['error'];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    return data;
  }
}