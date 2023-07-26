import 'package:flutter/material.dart';

class ChatItem extends StatelessWidget {
  const ChatItem({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage("https://images.unsplash.com/photo-1633332755192-727a05c4013d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8dXNlcnxlbnwwfHwwfHx8MA%3D%3D&w=1000&q=80"),
        radius: 30,
      ),
      title: Text(
          "username",
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
      ),
      subtitle: Row(
        children: [
          Icon(Icons.done_all),
          SizedBox(width: 3,),
          Text(
            "Hi coding team",
            style: TextStyle(
              fontSize: 13,
            ),
          ),
        ],
      ),
      trailing: Text("18:18"),
    );
  }
}
