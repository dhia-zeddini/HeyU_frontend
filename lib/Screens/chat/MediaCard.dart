import 'dart:io';

import 'package:flutter/material.dart';

class MediaCard extends StatelessWidget {
  const MediaCard({super.key,required this.alignment ,required this.color,required this.path});
  final Alignment alignment;
  final Color? color;
  final String path;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 15),
        child: Container(
          height: MediaQuery.of(context).size.height/2.3,
          width: MediaQuery.of(context).size.width/1.8,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: color,
          ),
          child: Card(
            margin: const EdgeInsets.all(3),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15)
            ),
            child: Image.file(File(path)),
          ),
        ),
      ),
    );
  }
}
