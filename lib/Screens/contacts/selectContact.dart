import 'package:flutter/material.dart';
import 'package:heyu_front/Screens/contacts/contactCard.dart';

import '../../Models/UserModel.dart';
import '../../Services/user_service.dart';

class SelectContact extends StatefulWidget {
  const SelectContact({super.key});

  @override
  State<SelectContact> createState() => _SelectContactState();
}

class _SelectContactState extends State<SelectContact> {
  List<UserModel> contacts = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadContacts();
  }

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
              Text(
                "20 Contacts",
                style: TextStyle(
                  fontSize: 13,
                ),
              ),
            ],
          ),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
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
                    child: Text("Refresh"),
                  ),
                  const PopupMenuItem(
                    value: "help",
                    child: Text("Help"),
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
        body: ListView.builder(
            itemCount: contacts.length+1,
            itemBuilder: (context, index) {
              if(index==0){
                return addContactBtn();
              }
                return ContactCard(
                  contact: contacts[index-1],
                );



            }));
  }

  Future<void> loadContacts() async {
    try {
      List<UserModel>? userContacts = await UserService.getUserContacts();
      if (userContacts != null) {
        setState(() {
          contacts = userContacts;
        });
      }
    } catch (e) {
      print('Error loading contacts: $e');
    }
  }

  Widget addContactBtn() {
    return InkWell(
      onTap: () {},
      child: const ListTile(
        leading: CircleAvatar(
          radius: 23,
          backgroundColor: Colors.pink,
          child: Icon(
            Icons.person_add,
            color: Colors.white,
          ),
        ),
        title: Text(
          "New Contact",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
