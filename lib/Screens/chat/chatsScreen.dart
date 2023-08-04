import 'package:flutter/material.dart';
import 'package:heyu_front/Models/ChatModel.dart';
import 'package:heyu_front/Screens/chat/chat_item.dart';
import 'package:heyu_front/Screens/contacts/selectContact.dart';
import 'package:heyu_front/Services/chat_service.dart';
import 'package:heyu_front/Services/user_service.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  List<ChatModel> chats = [];

  @override
  void initState() {
    super.initState();
    loadChats();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.pink,
        onPressed: () {
          // Add new chat
          //ChatService.createChat("64c706750e0bb48102b6ca26");
          UserService.getUserContacts();
          Navigator.push(context, MaterialPageRoute(builder: (builder)=>SelectContact()));
        },
        child: const Icon(Icons.chat),
      ),
      body: chats.isNotEmpty?ListView.builder(
        itemCount: chats.length,
        itemBuilder: (context, index) => ChatItem(chatModel: chats[index]),
      ):Container(),
    );
  }

  Future<void> loadChats() async {
    try {
      List<ChatModel>? userChats = await ChatService.getUserChats();
      if (userChats != null) {
        setState(() {
          chats = userChats;
        });
      }
    } catch (e) {
      print('Error loading chats: $e');
    }
  }
}
