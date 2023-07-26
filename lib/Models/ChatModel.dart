import 'package:heyu_front/Models/MessageModel.dart';

import 'UserModel.dart';

class ChatModel {
  late String chatId;
  late String chatName;
  late bool isGroupeChat;
  late List<UserModel> users;
  late List<MessageModel?>? messages;
  late DateTime createdAt;
  late DateTime updatedAt;
  late List<UserModel?>? archives;
  late List<UserModel?>? deleted;
  late String? theme;
  late String? wallpaper;

  ChatModel(
      {
        required this.chatId,
        required this.chatName,
        required this.isGroupeChat,
        required this.users,
        this.messages,
        required this.createdAt,
        required this.updatedAt,
        this.archives,
        this.deleted,
        this.theme,
        this.wallpaper});

  ChatModel.fromJson(Map<String, dynamic> json) {
    chatId = json['_id'] ;
    chatName = json['chatName'];
    isGroupeChat = json['isGroupeChat'];
    if (json['users'] != null) {
      users = <UserModel>[];
      json['users'].forEach((v) {
        users.add(UserModel.fromJson(v));
      });
    }
    if (json['messages'] != null) {
      messages = <MessageModel>[];
      json['messages'].forEach((v) {
        messages!.add(MessageModel!.fromJson(v));
      });
    }
    createdAt = json['createdAt'] ;
    updatedAt = json['updatedAt'] ;

    if (json['archives'] != null) {
      archives = <UserModel>[];
      json['archives'].forEach((v) {
        archives!.add(UserModel.fromJson(v));
      });
    }
    if (json['deleted'] != null) {
      deleted = <UserModel>[];
      json['deleted'].forEach((v) {
        deleted!.add(UserModel.fromJson(v));
      });
    }
    theme = json['theme'];
    wallpaper = json['wallpaper'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
      data['_id'] = chatId;
    data['chatName'] = chatName;
    data['isGroupeChat'] = isGroupeChat;
    if (users != null) {
      data['users'] = users.map((v) => v.toJson()).toList();
    }
    if (messages != null) {
      data['messages'] = messages!.map((v) => v.toJson()).toList();
    }
      data['createdAt'] = createdAt;
      data['updatedAt'] = updatedAt;
    if (archives != null) {
      data['archives'] = archives!.map((v) => v!.toJson()).toList();
    }
    if (deleted != null) {
      data['deleted'] = deleted!.map((v) => v!.toJson()).toList();
    }
    data['theme'] = theme;
    data['wallpaper'] = wallpaper;
    return data;
  }
}


