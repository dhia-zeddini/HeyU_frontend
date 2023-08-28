import 'package:flutter/material.dart';
import 'package:heyu_front/Screens/auth/LoginPage.dart';
import 'package:heyu_front/Screens/authentcation/LoginScreen.dart';

import '../../Services/shared_service.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();

}

class _LandingPageState extends State<LandingPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              const Text(
                "Welcome to HeyU",
                style: TextStyle(
                  color: Colors.pink,
                  fontSize: 29,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 8,
              ),
              Image.asset(
                "assets/images/circle.png",
                color: Colors.pink[700],
                height: 300,
                width: 300,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 9,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: RichText(
                    textAlign: TextAlign.center,
                    text: const TextSpan(
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                        ),
                        children: [
                          TextSpan(
                              text: "Agree and continue to accept the ",
                              style: TextStyle(color: Colors.grey)),
                          TextSpan(
                              text: "HeyU terms of service and Privacy Policy",
                              style: TextStyle(color: Colors.pinkAccent)),
                        ])),
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: (){
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (builder)=>const LoginScreen()),(route)=>false);
                },
                child: Container(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width-110,
                    height: 50,
                    child: const Card(
                      margin: EdgeInsets.all(0),
                      elevation: 8,
                      color: Colors.pinkAccent,
                      child:  Center(
                        child: Text("AGREE AND CONTINUE",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 18),
                        ),

                      ),
                    ),
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
