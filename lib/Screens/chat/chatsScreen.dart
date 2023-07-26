import 'package:flutter/material.dart';
import 'package:heyu_front/Screens/chat/chat_item.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({super.key});

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.pink,
        onPressed: (){},//add new chat
        child: const Icon(Icons.chat),
      ),
      body: ListView(
        children: [
          ChatItem(),
        ],
      ),
    );
  }
}
