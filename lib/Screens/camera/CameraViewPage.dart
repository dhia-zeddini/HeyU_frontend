import 'dart:io';

import 'package:flutter/material.dart';

class CameraViewPage extends StatelessWidget {
  const CameraViewPage({super.key, required this.path,required this.onImageSend});
  final String path;
  final Function onImageSend;

  @override
  Widget build(BuildContext context) {
    TextEditingController textEditingController = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.crop_rotate),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.emoji_emotions_outlined),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.title),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.edit),
          ),
        ],
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height - 150,
              child: Image.file(
                File(path),
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                color: Colors.black38,
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                child: TextFormField(
                  controller: textEditingController,
                  maxLines: 6,
                  minLines: 1,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                  ),
                  decoration:  InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: const Icon(
                      Icons.add_photo_alternate,
                      color: Colors.white,
                      size: 27,
                    ),
                    hintText: "Add Caption ....",
                    hintStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                    ),

                    suffixIcon: InkWell(
                      onTap: (){
                        String content;
                        textEditingController.text.isNotEmpty?content=textEditingController.text:content=" ";
                        onImageSend(content,path);
                        //print(textEditingController.text);
                      },
                      child: const CircleAvatar(
                        radius: 27,
                        backgroundColor: Colors.pinkAccent,
                        child: Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 27,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
