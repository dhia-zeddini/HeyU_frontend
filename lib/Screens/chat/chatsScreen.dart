import 'package:flutter/material.dart';
import 'package:heyu_front/Models/ChatModel.dart';
import 'package:heyu_front/Screens/chat/chat_item.dart';
import 'package:heyu_front/Services/chat_service.dart';

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
        },
        child: const Icon(Icons.chat),
      ),
      body: ListView.builder(
        itemCount: chats.length,
        itemBuilder: (context, index) => ChatItem(chatModel: chats[index]),
      ),
    );
  }

  Future<void> loadChats() async {
    //try {
      List<ChatModel>? userChats = await ChatService.getUserChats();
      if (userChats != null) {
        setState(() {
          chats = userChats;
        });
      }
   /* } catch (e) {
      print('Error loading chats: $e');
    }*/
  }
}
