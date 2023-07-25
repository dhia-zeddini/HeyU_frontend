import 'package:flutter/material.dart';
import 'package:heyu_front/Models/Login_response_model.dart';
import 'package:heyu_front/Services/shared_service.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  late Future<LoginResponseModel?> data;

  @override
  void initState() {
    super.initState();
    data = SharedService.loginDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("hey"),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              SharedService.logout(context);
            },
            icon: const Icon(Icons.logout, color: Colors.black),
          ),
        ],
      ),
      body: FutureBuilder<LoginResponseModel?>(
        future: data,
        builder: (BuildContext context, AsyncSnapshot<LoginResponseModel?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData) {
            return Text(snapshot.data!.token);
          } else {
            return const Center(
              child: Text("Error occurred!"),
            );
          }
        },
      ),
    );
  }
}
