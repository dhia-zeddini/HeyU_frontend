import 'package:flutter/material.dart';
import 'package:heyu_front/Models/ChatModel.dart';

class ChatItem extends StatelessWidget {
  const ChatItem({super.key,required this.chatModel});
  final ChatModel chatModel;


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){},
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage("https://images.unsplash.com/photo-1633332755192-727a05c4013d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8dXNlcnxlbnwwfHwwfHx8MA%3D%3D&w=1000&q=80"),
              radius: 30,
            ),
            title: Text(
                chatModel.chatName,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            ),
            subtitle: Row(
              children: [
                const Icon(Icons.done_all),
                const SizedBox(width: 3,),
                Text(
                  chatModel.messages![0].content,
                  style: const TextStyle(
                    fontSize: 13,
                  ),
                ),
              ],
            ),
            trailing: Text(chatModel.messages![0].createdAt.toString()),
          ),
          const Padding(
            padding: EdgeInsets.only(right: 20,left: 80),
            child: Divider(thickness: 1,),
          )
        ],
      ),
    );

  }
  /*String latestMessage(){
    var msg = chatModel.messages != null
        ? chatModel!.messages![1]
        : "";

    return msg;
  }
  String latestMessageTime(){
    var msg = chatModel.messages != null
        ? chatModel!.messages![1]
        : "";

    return msg.toString();
  }*/
}
