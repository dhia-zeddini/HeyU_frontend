import 'package:heyu_front/Models/ChatModel.dart';
import 'package:heyu_front/Models/UserModel.dart';

class MessageModel {
  late String messageId;
  late String sender;
  late String content;
  late String receiverId;
  late String? chatId;
  late DateTime createdAt;
  late DateTime updatedAt;
  late List<String?>? deleted;

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
    sender = json['sender']['_id'];
    content = json['content'];
    receiverId = json['receiverId'];
    chatId = json['chatId'];
    createdAt = DateTime.parse(json['createdAt']);
    updatedAt = DateTime.parse(json['updatedAt']);
    if (json['deleted'] != null) {
      deleted = <String>[];
      json['deleted'].forEach((v) {
        deleted!.add(v);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    /*if (this.messageId != null) {
      data['_id'] = this.iId.toJson();
    }*/

    data['sender'] = sender;
    data['content'] = content;
    data['receiverId'] = receiverId;
    data['chatId'] = chatId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['deleted'] = deleted!.map((v) => v).toList();

    return data;
  }
}
