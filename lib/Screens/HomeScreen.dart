import 'package:flutter/material.dart';
import 'package:heyu_front/Models/Login_response_model.dart';
import 'package:heyu_front/Screens/chat/chatsScreen.dart';
import 'package:heyu_front/Services/shared_service.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late Future<LoginResponseModel?> data;
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    data = SharedService.loginDetails();
    tabController = TabController(length: 4, vsync: this, initialIndex: 1);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: const Text(
          "HeyU",
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.bold,
            letterSpacing: 3,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              SharedService.logout(context);
            },
            icon: const Icon(Icons.logout),
          ),

          PopupMenuButton<String>(
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  child: Text("Profile"),
                  value: "profile",
                ),
                PopupMenuItem(
                  child: Text("New brodcast"),
                  value: "brodcast",
                ),
                PopupMenuItem(
                  child: Text("Archive"),
                  value: "archive",
                ),
                PopupMenuItem(
                  child: Text("Settings"),
                  value: "settings",
                ),
                PopupMenuItem(
                  child: Text("Logout"),
                  value: "logout",
                ),
              ];
            },
            icon: const Icon(Icons.more_vert),
            onSelected: (value){
              print(value);
            },
          )
        ],
        bottom: TabBar(
          controller: tabController,
          tabs: [
            Tab(
              icon: Icon(Icons.camera_alt),
            ),
            Tab(
              text: "CHATS",
            ),
            Tab(
              text: "GROUPS",
            ),
            Tab(
              text: "CALLS",
            )
          ],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          Text("camera"),
          ChatsScreen(),
          Text("groups"),
          Text("calls"),
        ],
      ),
    );
  }
}
