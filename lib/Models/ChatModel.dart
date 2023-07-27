import 'package:heyu_front/Models/MessageModel.dart';
import 'package:heyu_front/Models/UserModel.dart';

List<ChatModel> chatsFromJson(dynamic str) =>
    List<ChatModel>.from((str).map((x) => ChatModel.fromJson(x)));

class ChatModel {
  late String chatId;
  late String chatName;
  late bool isGroupChat;
  late List<UserModel> users;
  List<MessageModel>? messages;
  late DateTime createdAt;
  late DateTime updatedAt;
  List<String>? archives;
  List<String>? deleted;
  String? theme;
  String? wallpaper;
  late String image;

  ChatModel({
    required this.chatId,
    required this.chatName,
    required this.isGroupChat,
    required this.users,
    this.messages,
    required this.createdAt,
    required this.updatedAt,
    this.archives,
    this.deleted,
    this.theme,
    this.wallpaper,
    required this.image
  });

  ChatModel.fromJson(Map<String, dynamic> json) {
    chatId = json['_id']?? '';
    chatName = json['chatName'] ?? '';
    isGroupChat = json['isGroupChat']??false;
    if (json['users'] != null) {
      users = <UserModel>[];
      json['users'].forEach((v) {
        users.add(UserModel.fromJson(v));
      });
    }else{
      print("user error");
    }
    if (json['messages'] != null) {
      messages = <MessageModel>[];
      json['messages'].forEach((v) {
        messages!.add(MessageModel.fromJson(v));
      });
    }else{
      print("message error");
    }
    createdAt = DateTime.parse(json['createdAt']);
    updatedAt = DateTime.parse(json['updatedAt']);

    if (json['archives'] != null) {
      archives = <String>[];
      json['archives'].forEach((v) {
        archives!.add(v);
      });
    }
    if (json['deleted'] != null) {
      deleted = <String>[];
      json['deleted'].forEach((v) {
        deleted!.add(v);
      });
    }
    theme = json['theme'];
    wallpaper = json['wallpaper'];
    image=json['users'][1]['avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = chatId;
    data['chatName'] = chatName;
    data['isGroupChat'] = isGroupChat;
    data['users'] = users.map((v) => v).toList();
    if (messages != null) {
      data['messages'] = messages!.map((v) => v).toList();
    }
    data['createdAt'] = createdAt.toIso8601String();
    data['updatedAt'] = updatedAt.toIso8601String();
    if (archives != null) {
      data['archives'] = archives!.map((v) => v).toList();
    }
    if (deleted != null) {
      data['deleted'] = deleted!.map((v) => v).toList();
    }
    data['theme'] = theme;
    data['wallpaper'] = wallpaper;
    return data;
  }
}
