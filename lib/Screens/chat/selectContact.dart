import 'package:flutter/material.dart';

class SelectContact extends StatefulWidget {
  const SelectContact({super.key});

  @override
  State<SelectContact> createState() => _SelectContactState();
}

class _SelectContactState extends State<SelectContact> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        leadingWidth: 70,
        titleSpacing: 0,
        title: const Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Select Contact",
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
            ),
            Text("20 Contacts",
              style: TextStyle(fontSize: 13, ),
            ),
          ],
        ),
        actions: [
          IconButton(onPressed: (){}, icon: const Icon(Icons.search)),
          PopupMenuButton<String>(
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem(
                  value: "inviteFriend",
                  child: Text("Invite a Friend"),
                ),
                const PopupMenuItem(
                  value: "contacts",
                  child: Text("Contacts"),
                ),
                const PopupMenuItem(
                  value: "refresh",
                  child:  Text("Refresh"),
                ),
                const PopupMenuItem(
                  value: "help",
                  child:  Text("Help"),
                ),

              ];
            },
            icon: const Icon(Icons.more_vert),
            onSelected: (value) {
              print(value);
            },
          )
        ],
      ),
    );
  }
}
