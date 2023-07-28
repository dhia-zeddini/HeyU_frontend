import 'package:emoji_selector/emoji_selector.dart';
import 'package:flutter/material.dart';
import 'package:heyu_front/Models/ChatModel.dart';

class IndivChatScreen extends StatefulWidget {
  const IndivChatScreen({super.key, required this.chatModel});

  final ChatModel chatModel;

  @override
  State<IndivChatScreen> createState() => _IndivChatScreenState();
}

class _IndivChatScreenState extends State<IndivChatScreen> {
  bool showEmojis = false;
  FocusNode focusNode = FocusNode();
  TextEditingController textEditingController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        setState(() {
          showEmojis = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Colors.pink,
        leadingWidth: 70,
        titleSpacing: 0,
        leading: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.arrow_back,
                  size: 24,
                )),
            CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(
                  "https://images.unsplash.com/photo-1633332755192-727a05c4013d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8dXNlcnxlbnwwfHwwfHx8MA%3D%3D&w=1000&q=80"),
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
                const Text(
                  "last seen today at 18:18",
                  style: TextStyle(
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
                  child: Text("Profile"),
                  value: "profile",
                ),
                const PopupMenuItem(
                  value: "brodcast",
                  child: const Text("New brodcast"),
                ),
                const PopupMenuItem(
                  child: const Text("Archive"),
                  value: "archive",
                ),
                const PopupMenuItem(
                  child: const Text("Settings"),
                  value: "settings",
                ),
                const PopupMenuItem(
                  child: const Text("Logout"),
                  value: "logout",
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
        child: Stack(
          children: [
            ListView(),
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
                                    onPressed: () {},
                                  ),
                                ],
                              ),
                              contentPadding: const EdgeInsets.all(5),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(bottom: 8, right: 3, left: 3),
                        child: CircleAvatar(
                          backgroundColor: Colors.pink,
                          radius: 25,
                          child: IconButton(
                            icon: Icon(
                              Icons.mic,
                              color: Colors.white,
                            ),
                            onPressed: () {},
                          ),
                        ),
                      ),
                    ],
                  ),
                  showEmojis ? emojiSelect() : Container(),
                ],
              ),
            )
          ],
        ),
      ),
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
      /*padding: EdgeInsets.only(top: 60),*/
    );
  }

  Widget bottomSheet() {
    return Container(
      height: 278,
      width: MediaQuery.of(context).size.width,
      child: Card(
        margin: EdgeInsets.all(18),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  iconCreation(Icons.insert_drive_file,Colors.blue,"Document"),
                  const SizedBox(width: 40,),
                  iconCreation(Icons.camera_alt,Colors.pink,"Camera"),
                  const SizedBox(width: 40,),
                  iconCreation(Icons.insert_photo,Colors.purple,"Gallery"),
                ],
              ),
              const SizedBox(height: 30,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  iconCreation(Icons.headset,Colors.orange,"Audio"),
                  const SizedBox(width: 40,),
                  iconCreation(Icons.location_pin,Colors.cyan,"Location"),
                  const SizedBox(width: 40,),
                  iconCreation(Icons.person,Colors.lightGreen,"Contact"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget iconCreation(IconData icon, Color color, String text) {
    return InkWell(
      onTap: (){},
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
          const SizedBox(height: 5,),
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
}
