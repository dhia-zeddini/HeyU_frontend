
import 'dart:convert';

import 'package:heyu_front/Models/ChatModel.dart';
import 'package:heyu_front/Models/MessageModel.dart';
import 'package:heyu_front/Services/shared_service.dart';
import 'package:heyu_front/config.dart';
import 'package:http/http.dart'as http;
import 'package:http_parser/http_parser.dart';

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
  static Future<List<dynamic>> sendMessage(String content,String reciver,String chat,String mediaPath)async{
    var userToken=await SharedService.loginDetails();
    Map<String,String> requestHeaders={
      'Content-Type':'application/json',
      'token':"Bearer ${userToken!.token}"
    };
    Map<String, String> requestBody = {
      "content":content,
      "chatId":chat,
      "receiverId":reciver,
      "mediaPath":mediaPath,
    };
    var url=Uri.http(Config.apiURL,Config.chatMessages);
    var response=await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(requestBody),
    );
    print(url);
    print(response.body);
    if(response.statusCode==200){
      MessageModel msg=MessageModel.fromJson(jsonDecode(response.body));
      print(msg);

      var messsageMap=msg.toJson();
      return [true,msg,messsageMap];
    }else{
      return [false];
    }
  }

  static Future<bool> sendImage(String mediaPath)async{
    var url = Uri.http(Config.apiURL, Config.sendImg);
   var request=http.MultipartRequest("POST", url);
   request.files.add(await http.MultipartFile.fromPath('img', mediaPath));
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',

    };
    request.headers.addAll(requestHeaders);
    http.StreamedResponse response= await request.send();
    print(url);
    print(response);
    return true;
  }

 /* static Future<List<dynamic>> sendMessage(String content, String receiver, String chat, String mediaPath) async {
    var userToken = await SharedService.loginDetails();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'token': "Bearer ${userToken!.token}"
    };

    var url = Uri.http(Config.apiURL, Config.chatMessages);

    // Create a new multipart request
    var request = http.MultipartRequest('POST', url);
    request.headers.addAll(requestHeaders);

    // Add text fields to the request
    request.fields['content'] = content;
    request.fields['chatId'] = chat;
    request.fields['receiverId'] = receiver;

    // Add the image file as a multipart form data
    if (mediaPath!="") {
      var image = await http.MultipartFile.fromPath('media', mediaPath,
          contentType: MediaType('image', 'jpeg')); // Change 'jpeg' to the actual image format
      request.files.add(image);
    }

    // Send the request and get the response
    var response = await http.Response.fromStream(await request.send());
print(request.fields);
    if (response.statusCode == 200) {
      MessageModel msg = MessageModel.fromJson(jsonDecode(response.body));
      print(msg);

      var messageMap = msg.toJson();
      return [true, msg, messageMap];
    } else {
      return [false];
    }
  }*/


}