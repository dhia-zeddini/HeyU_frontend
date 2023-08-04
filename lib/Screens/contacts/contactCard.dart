import 'package:flutter/material.dart';
import 'package:heyu_front/Models/UserModel.dart';

class ContactCard extends StatelessWidget {
  const ContactCard({super.key,required this.contact});
  final UserModel contact;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){},
      child: ListTile(
        leading: CircleAvatar(
          radius: 23,
          backgroundColor: Colors.blueGrey[200],
          child: const Icon(Icons.person,color: Colors.white,),
        ),
        title: Text(contact.userName,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,

        ),
        ),
        subtitle: Text(contact.phoneNumber,style: const TextStyle(fontSize: 13),),

      ),
    );
  }
}
