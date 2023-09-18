import 'package:flutter/material.dart';
import 'package:heyu_front/Models/Login_response_model.dart';
import 'package:heyu_front/Screens/account/profilePage.dart';
import 'package:heyu_front/Screens/camera/CameraPage.dart';
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

            },
            icon: const Icon(Icons.search),
          ),

          PopupMenuButton<String>(
            itemBuilder: (BuildContext context) {
              return [
                 PopupMenuItem(
                  value: "profile",
                  child: const Text("Profile"),

                ),
                const PopupMenuItem(
                  value: "broadcast",
                  child: Text("New broadcast"),
                ),
                const PopupMenuItem(
                  value: "archive",
                  child: Text("Archive"),
                ),
                const PopupMenuItem(
                  value: "settings",
                  child: Text("Settings"),
                ),
                 PopupMenuItem(
                  value: "logout",
                  child: const Text("Logout"),
                  onTap: (){
                    SharedService.logout(context);
                  },
                ),
              ];
            },
            icon: const Icon(Icons.more_vert),
            onSelected: (value){
              if(value=="profile"){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProfilePage(),
                  ),
                );
              }
            },
          )
        ],
        bottom: TabBar(
          indicatorColor: Colors.white,
          controller: tabController,
          tabs: const [
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
        children: const [
          CameraPage(),
          ChatsScreen(),
          Text("groups"),
          Text("calls"),
        ],
      ),
    );
  }
}
