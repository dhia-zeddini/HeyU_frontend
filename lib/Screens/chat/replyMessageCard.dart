import 'package:flutter/material.dart';
import 'package:heyu_front/Services/shared_service.dart';

import '../../Models/MessageModel.dart';

class ReplyMessageCard extends StatelessWidget {
  const ReplyMessageCard({super.key,required this.messageModel});
  final MessageModel messageModel;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width - 45,
        ),
        child: Card(
          elevation: 1,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          color: Colors.blueAccent.withOpacity(0.3),
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: Stack(
            children: [
              Padding(
                padding:
                    EdgeInsets.only(left: 10, right: 60, top: 5, bottom: 25),
                child: Text(
                  messageModel.content,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              Positioned(
                bottom: 4,
                right: 10,
                child: Text(
                  SharedService.msgTime(messageModel.createdAt),
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
