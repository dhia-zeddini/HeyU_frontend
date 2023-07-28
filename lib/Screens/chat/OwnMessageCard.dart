import 'package:flutter/material.dart';

class OwnMessageCard extends StatelessWidget {
  const OwnMessageCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width - 45,
        ),
        child:   Card(
          elevation: 1,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          color: Colors.pinkAccent.withOpacity(0.6),
          margin: EdgeInsets.symmetric(horizontal: 15,vertical: 5),
          child: Stack(
            children: [
              Padding(
                padding:
                    EdgeInsets.only(left: 10, right: 60, top: 5, bottom: 25),
                child: Text("hey giukgbkljuhouhoi fjgvjgiuhoeizhocujrzn izhfoirehz heaiuzdgik",
                style: TextStyle(
                  fontSize: 16,
                ),),
              ),
              Positioned(
                bottom: 4,
                right: 10,
                child: Row(
                  children: [
                    Text("12:12",style: TextStyle(
                      fontSize: 13,
                      color: Colors.white,
                    ),),
                    SizedBox(width: 5,),
                    Icon(Icons.done_all,size: 20,),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
