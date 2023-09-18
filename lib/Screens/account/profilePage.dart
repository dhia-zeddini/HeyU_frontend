import 'package:flutter/material.dart';
import 'package:heyu_front/Models/UserModel.dart';
import 'package:heyu_front/Services/user_service.dart';
import 'package:snippet_coder_utils/FormHelper.dart';

import '../../config.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  UserModel? userData;
  bool noEdit = true;
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController =  TextEditingController();
  TextEditingController emailController =  TextEditingController();
  TextEditingController phoneController =  TextEditingController();
  TextEditingController userNameController =  TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        leadingWidth: 70,
        titleSpacing: 0,
        title: const Text("Profile"),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 15, top: 20, right: 15),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              Center(
                child: Stack(
                  children: [
                    Container(
                      width: 130,
                      height: 130,
                      decoration: BoxDecoration(
                          border: Border.all(width: 4, color: Colors.white),
                          boxShadow: [
                            BoxShadow(
                                spreadRadius: 2,
                                blurRadius: 10,
                                color: Colors.black.withOpacity(0.1))
                          ],
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                "http://${Config.apiURL}${Config.avatarsUrl}${userData!.avatar}"),
                          )),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(width: 4, color: Colors.white),
                            color: Colors.pinkAccent),
                        child: const Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 30),
              buildTextField("First name", userData!.firstName,firstNameController),
              buildTextField("Last name", userData!.lastName,lastNameController),
              buildTextField("UserName", userData!.lastName,userNameController),
              buildTextField("Email", userData!.email,emailController),
              buildTextField("Phone Number", userData!.phoneNumber,phoneController),
              const SizedBox(height: 30),
              noEdit?Container():showBtn()
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String label,String text, TextEditingController controller) {
    controller.text=text;
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 30),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(bottom: 5),
          labelText: label,
          labelStyle: const TextStyle(color: Colors.pink),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          //hintText: placeholder,
          //hintStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        readOnly: noEdit,
        onTap: () {
          _showMyDialog("Profile edit", "Do you want to edit your profile?",
              () {
            setState(() {
              noEdit = false;
            });
            Navigator.of(context).pop();
          });
        },
      ),
    );
  }

  Future<void> getUserData() async {
    try {
      UserModel? data = await UserService.getUser();
      if (data != null) {
        setState(() {
          userData = data;
        });
      }
    } catch (e) {
      print('Error loading chats: $e');
    }
  }

  Future<void> _showMyDialog(
      String title, String msg, void Function()? toDo) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(msg),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(onPressed: toDo, child: const Text('Yes')),
            TextButton(
              child: const Text('No'),
              onPressed: () {
                setState(() {
                  noEdit = true;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget showBtn() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        OutlinedButton(
            onPressed: () {
              setState(() {
                firstNameController.text=userData!.firstName;
                lastNameController.text=userData!.lastName;
                userNameController.text=userData!.userName;
                emailController.text=userData!.email;
                phoneController.text=userData!.phoneNumber;
              });
            },
            style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20))),
            child: const Text(
              "CANCEL",
              style: TextStyle(
                  fontSize: 15, letterSpacing: 2, color: Colors.black),
            )),
        ElevatedButton(
            onPressed: () async{
              UserService.updateAcount(firstNameController.text, lastNameController.text, userNameController.text,
                  phoneController.text, emailController.text, userData!.avatar).then((response) {
                if (response) {
                  FormHelper.showSimpleAlertDialog(context,
                      Config.appName, "Your account has been updated successfully", "OK", () async{
                        Navigator.pop(context);
                        setState(() {
                          noEdit=true;
                        });
                      });
                } else {
                  FormHelper.showSimpleAlertDialog(context,
                      Config.appName, "Something is messing", "OK", () {
                        Navigator.pop(context);
                      });
                }
              });
            },
            style: OutlinedButton.styleFrom(
                backgroundColor: Colors.pinkAccent,
                padding: const EdgeInsets.symmetric(horizontal: 50),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20))),
            child: const Text(
              "SAVE",
              style: TextStyle(
                  fontSize: 15, letterSpacing: 2, color: Colors.black),
            ))
      ],
    );
  }
}
