import 'package:heyu_front/Models/ChatModel.dart';
import 'package:heyu_front/Models/UserModel.dart';

class MessageModel {
  late String messageId;
  late UserModel sender;
  late String content;
  late UserModel receiverId;
  late ChatModel? chatId;
  late DateTime createdAt;
  late DateTime updatedAt;
  late List<UserModel?>? deleted;

  MessageModel(
      {required this.messageId,
      required this.sender,
      required this.content,
      required this.receiverId,
      this.chatId,
      required this.createdAt,
      required this.updatedAt,
      this.deleted});

  MessageModel.fromJson(Map<String, dynamic> json) {
    messageId = json['_id'];
    sender = json['sender'];
    content = json['content'];
    receiverId = json['receiverId'];
    chatId = json['chatId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    if (json['deleted'] != null) {
      deleted = <UserModel>[];
      json['deleted'].forEach((v) {
        deleted!.add(UserModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    /*if (this.messageId != null) {
      data['_id'] = this.iId.toJson();
    }*/

    data['sender'] = sender.toJson();
    data['content'] = content;
    data['receiverId'] = receiverId.toJson();
    data['chatId'] = chatId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['deleted'] = deleted!.map((v) => v!.toJson()).toList();

    return data;
  }
}
