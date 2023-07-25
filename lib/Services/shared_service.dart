import 'dart:convert';


import 'package:api_cache_manager/api_cache_manager.dart';
import 'package:api_cache_manager/models/cache_db_model.dart';
import 'package:flutter/material.dart';
import 'package:heyu_front/Models/Login_response_model.dart';

class SharedService {
  static Future<bool> isLoggedIn() async {
    return await APICacheManager().isAPICacheKeyExist("login_details");
  }

  static Future<LoginResponseModel?> loginDetails() async {
    if (await isLoggedIn()) {
      var cacheData = await APICacheManager().getCacheData("login_details");
      print(loginResponseJson(cacheData.syncData).token);
      return loginResponseJson(cacheData.syncData);
    }
  }

  static Future<void> setLogindetails(LoginResponseModel model) async {
    APICacheDBModel cacheDBModel = APICacheDBModel(
        key: "login_details", syncData: jsonEncode(model.toJson()));
    await APICacheManager().addCacheData(cacheDBModel);
  }

  static Future<void> logout(BuildContext context) async{
    await APICacheManager().deleteCache("login_details");
    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
  }
}
