import 'package:flutter/material.dart';
import 'package:heyu_front/Models/ChatModel.dart';
import 'package:heyu_front/Screens/chat/indivChatScreen.dart';
import 'package:heyu_front/Services/shared_service.dart';

import '../../config.dart';

class ChatItem extends StatelessWidget {
  const ChatItem({super.key, required this.chatModel});

  final ChatModel chatModel;

  @override
  Widget build(BuildContext context) {
    if (chatModel.messages!.isNotEmpty) {
        return FutureBuilder<List<String>>(
          future: chatName(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return const Icon(Icons.error, color: Colors.red);
            } else {
              final chatName = snapshot.data;
              if (chatName == null) {
                return Container();
              }
              return InkWell(
                onTap: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => IndivChatScreen(
                        chatModel: chatModel,
                        title: chatName[0],
                        avatar:chatName[1]
                      ),
                    ),
                  );
                },
                child: Column(
                  children: [
                    ListTile(
                      leading:  CircleAvatar(
                        backgroundImage: NetworkImage(
                            "http://${Config.apiURL}${Config.avatarsUrl}${chatName[1]}"
                        ),
                        radius: 30,
                      ),
                      title: Text(
                        chatName[0],
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        chatModel.messages![0].content,
                        style: const TextStyle(
                          fontSize: 13,
                        ),
                      ),
                      trailing: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(SharedService.msgTime(chatModel.messages![0].createdAt)),
                          /*const SizedBox(height: 4,),*/
                          FutureBuilder<bool>(
                            future: SharedService.messageSenderTest(
                                chatModel.messages![0].sender),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return const CircularProgressIndicator();
                              } else if (snapshot.hasError) {
                                return const Icon(Icons.error, color: Colors.red);
                              } else {
                                bool isSender = snapshot.data ?? false;
                                return Icon(
                                  isSender
                                      ? Icons.arrow_circle_right
                                      : Icons.arrow_circle_left,
                                  color: Colors.blueAccent,
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(right: 20, left: 80),
                      child: Divider(
                        thickness: 1,
                      ),
                    )
                  ],
                ),
              );
            }
          },
        );

    } else {
      return Container();
    }
  }
  Future<List<String>> chatName()async{
    String phoneNumber;
    String avatar;
    String id= await SharedService.userId();
    if(chatModel.users[0].uId==id){
      phoneNumber=chatModel.users[1].phoneNumber;
      avatar=chatModel.users[1].avatar;
    }else{
      phoneNumber=chatModel.users[0].phoneNumber;
      avatar=chatModel.users[0].avatar;

    }
    return [phoneNumber,avatar];
  }
}
