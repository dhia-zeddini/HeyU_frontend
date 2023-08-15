import 'dart:async';

import 'package:emoji_selector/emoji_selector.dart';
import 'package:flutter/material.dart';
import 'package:heyu_front/Models/ChatModel.dart';
import 'package:heyu_front/Models/MessageModel.dart';
import 'package:heyu_front/Models/UserModel.dart';
import 'package:heyu_front/Screens/HomeScreen.dart';
import 'package:heyu_front/Screens/camera/CameraScreen.dart';
import 'package:heyu_front/Screens/camera/CameraViewPage.dart';
import 'package:heyu_front/Screens/chat/OwnMessageCard.dart';
import 'package:heyu_front/Screens/chat/replyMessageCard.dart';
import 'package:heyu_front/Services/message_service.dart';
import 'package:heyu_front/Services/shared_service.dart';
import 'package:heyu_front/config.dart';
import 'package:image_picker/image_picker.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'MediaCard.dart';

class IndivChatScreen extends StatefulWidget {
  const IndivChatScreen({super.key, required this.chatModel});

  final ChatModel chatModel;

  @override
  State<IndivChatScreen> createState() => _IndivChatScreenState();
}
//with WidgetsBindingObserver
class _IndivChatScreenState extends State<IndivChatScreen> {
  String avatar =
      "https://images.unsplash.com/photo-1633332755192-727a05c4013d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8dXNlcnxlbnwwfHwwfHx8MA%3D%3D&w=1000&q=80";
  final String url = "http://${Config.apiURL}";
  bool showEmojis = false;
  FocusNode focusNode = FocusNode();
  late IO.Socket socket = IO.io(url, <String, dynamic>{
    "transports": ['websocket'],
    "autoConnect": false,
  });
  late bool typing = false;
  TextEditingController textEditingController = TextEditingController();
  List<MessageModel> messages = [];
  ScrollController scrollController = ScrollController();
  ImagePicker picker = ImagePicker();
  XFile? file;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    connect();
    loadMessages();
    //WidgetsBinding.instance?.addObserver(this);
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        setState(() {
          showEmojis = false;
        });
      }
    });
  }
/*  @override
  void didChangeMetrics() {
    if (WidgetsBinding.instance?.window.viewInsets.bottom == 0) {
      // Keyboard closed, scroll to the end after a small delay
      Timer(const Duration(milliseconds: 100), () {
        scrollToBottom();
      });
    }
  }*/

  void connect() async {
    String connectedId = await SharedService.userId();
    socket.emit("setup", connectedId);
    socket.connect();
    socket.onConnect((_) {
      if (mounted) {
        print("connected to front end");
        joinChat();
        socket.on('typing', (status) {
          //if (mounted) {
          setState(() {
            typing = true;
          });
          print("typing");
          /*}else{
            print("not typing");
          }*/
        });
        socket.on('stop typing', (status) {
          setState(() {
            typing = false;
          });
        });
        socket.on('new message', (newMessageReceived) {
          //if (mounted) {
          print("*************");
          print(newMessageReceived);
          MessageModel receivedMessage =
              MessageModel.fromSocket(newMessageReceived);
          print("******new msg*******");
          print(receivedMessage);
          if (widget.chatModel.chatId == receivedMessage.chatId){
            setState(() {
              messages.insert(messages.length, receivedMessage);
              print("donne");
            });
          }

          /*} else {
          print("not mounted");
        }*/
        });
      } else {
        print("not mounted");
      }
    });
  }

  void joinChat() {
    socket.emit('join chat', widget.chatModel.chatId);
  }

  void sendTypingEvent(String status) {
    socket.emit('typing', status);
  }

  void sendStopTypingEvent(String status) {
    socket.emit('stop typing', status);
  }

  void sendMsg(String content, String receiver, String chat,String mediaPath) {
    MessageServive.sendMessage(content, receiver, chat,mediaPath).then((response) {
      var emission = response[2];
      socket.emit("new message", emission);
      setState(() {
        textEditingController.clear();
        messages.insert(messages.length, response[1]);
      });
      scrollToBottom();
    });
  }

  void onImageSend(String path){
    print(" working: $path");
   // MessageServive.sendMessage("content", "64c706750e0bb48102b6ca26", "64c70a8087c37bf074cb8fa7",path);
    MessageServive.sendImage(path);
  }

  void scrollToBottom() {
    Timer(const Duration(milliseconds: 100), () {
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    socket.off('setup');
    socket.off('typing');
    socket.off('stop typing');
    socket.off('new message');
    socket.disconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.network(
          "http://" +
              Config.apiURL +
              Config.wallpapersUrl +
              widget.chatModel.wallpaper,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.pink,
            leadingWidth: 70,
            titleSpacing: 0,
            leading: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
                    },
                    child: const Icon(
                      Icons.arrow_back,
                      size: 24,
                    )),
                CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(avatar),
                )
              ],
            ),
            title: InkWell(
              onTap: () {}, //for the contact profile
              child: Container(
                margin: const EdgeInsets.all(5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.chatModel.users[1].userName,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      !typing ? "last seen today at 18:18" : "typing ....",
                      style: const TextStyle(
                        fontSize: 13,
                      ),
                    )
                  ],
                ),
              ),
            ),
            actions: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.video_call)),
              IconButton(onPressed: () {}, icon: const Icon(Icons.call)),
              PopupMenuButton<String>(
                itemBuilder: (BuildContext context) {
                  return [
                    const PopupMenuItem(
                      value: "profile",
                      child: Text("Profile"),
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
                    const PopupMenuItem(
                      value: "logout",
                      child: Text("Logout"),
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
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Expanded(
                    //height: MediaQuery.of(context).size.height - 140,
                    child: FutureBuilder<String>(
                  future: SharedService.userId(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return const Text(
                          "Erreur lors de la récupération de l'ID utilisateur.");
                    } else {
                      String userId = snapshot.data ?? "";
                      return ListView.builder(
                          shrinkWrap: true,

                          controller: scrollController,
                          itemCount: messages.length,
                          itemBuilder: (context, index) => messages[index]
                                      .sender ==
                                  userId
                              ? OwnMessageCard(messageModel: messages[index])
                              : ReplyMessageCard(
                                  messageModel: messages[index]),
                      );

                    }
                  },
                ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width - 60,
                            child: Card(
                              margin: const EdgeInsets.only(left: 3, bottom: 8),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25)),
                              child: TextFormField(
                                controller: textEditingController,
                                focusNode: focusNode,
                                textAlignVertical: TextAlignVertical.center,
                                keyboardType: TextInputType.multiline,
                                maxLines: 5,
                                minLines: 1,
                                onTapOutside: (_) async {
                                  focusNode.unfocus();
                                  //focusNode.canRequestFocus = false;
                                  String receiver = await receiverId();
                                  sendStopTypingEvent(receiver);
                                },
                                onChanged: (_) async {
                                  String receiver = await receiverId();
                                  sendTypingEvent(receiver);
                                },
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Type a message",
                                  prefixIcon: IconButton(
                                    icon: const Icon(Icons.emoji_emotions),
                                    onPressed: () {
                                      focusNode.unfocus();
                                      focusNode.canRequestFocus = false;
                                      setState(() {
                                        showEmojis = !showEmojis;
                                      });
                                    },
                                  ),
                                  suffixIcon: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.attach_file),
                                        onPressed: () {
                                          showModalBottomSheet(
                                            context: context,
                                            builder: (builder) => bottomSheet(),
                                            backgroundColor: Colors.transparent,
                                          );
                                        },
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.camera_alt),
                                        onPressed: () {
                                          Navigator.push(context, MaterialPageRoute(builder: (builder)=>CameraScreen(onImageSend: onImageSend,)));
                                        },
                                      ),
                                    ],
                                  ),
                                  contentPadding: const EdgeInsets.all(5),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                bottom: 8, right: 3, left: 3),
                            child: CircleAvatar(
                              backgroundColor: Colors.pink,
                              radius: 25,
                              child: IconButton(
                                icon: const Icon(
                                  Icons.send,
                                  color: Colors.white,
                                ),
                                onPressed: () async {
                                  String receiver = await receiverId();
                                  sendMsg(textEditingController.text, receiver,
                                      widget.chatModel.chatId,"");
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                          color: Colors.white,
                          child: showEmojis ? emojiSelect() : Container()),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget emojiSelect() {
    return EmojiSelector(
      onSelected: (emoji) {
        print(emoji.char);
        setState(() {
          textEditingController.text = textEditingController.text + emoji.char;
        });
      },
    );
  }

  Widget bottomSheet() {
    return Container(
      height: 278,
      width: MediaQuery.of(context).size.width,
      child: Card(
        margin: const EdgeInsets.all(18),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  iconCreation(
                      Icons.insert_drive_file, Colors.blue, "Document",(){}),
                  const SizedBox(
                    width: 40,
                  ),
                  iconCreation(Icons.camera_alt, Colors.pink, "Camera",(){
                    Navigator.push(context, MaterialPageRoute(builder: (builder)=>CameraScreen(onImageSend: onImageSend)));
                  }),
                  const SizedBox(
                    width: 40,
                  ),
                  iconCreation(Icons.insert_photo, Colors.purple, "Gallery",()async{
                    file=await picker.pickImage(source: ImageSource.gallery);
                    if(file!=null){
                    Navigator.push(context, MaterialPageRoute(builder: (builder)=>CameraViewPage(
                        path: file!.path,
                      onImageSend: onImageSend,
                    ),),);
                    }
                    print(file?.name);
                  }),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  iconCreation(Icons.headset, Colors.orange, "Audio",(){}),
                  const SizedBox(
                    width: 40,
                  ),
                  iconCreation(Icons.location_pin, Colors.cyan, "Location",(){}),
                  const SizedBox(
                    width: 40,
                  ),
                  iconCreation(Icons.person, Colors.lightGreen, "Contact",(){}),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget iconCreation(IconData icon, Color color, String text,void Function() onTap) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: color,
            radius: 30,
            child: Icon(
              icon,
              size: 29,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            text,
            style: const TextStyle(
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> loadMessages() async {
    try {
      List<MessageModel>? chatMessages =
          await MessageServive.getChatMessages(widget.chatModel.chatId);
      if (chatMessages != null) {
        setState(() {
          messages = chatMessages;
        });
        scrollController.animateTo(scrollController.position.maxScrollExtent,
            duration: const Duration(microseconds: 300),
            curve: Curves.easeInOut);
      }
    } catch (e) {
      print('Error loading chats: $e');
    }
  }

  Future<String> receiverId() async {
    String connectedId = await SharedService.userId();
    for (UserModel user in widget.chatModel.users) {
      if (user.uId != connectedId) {
        return user.uId;
      }
    }
    throw Exception("Receiver ID not found.");
  }
}
