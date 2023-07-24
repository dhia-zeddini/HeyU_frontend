import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:heyu_front/Screens/authentcation/RegistrationScreen.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isAPIcallProcess = false;
  bool hidePwd = true;
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  String? phoneNumber;
  String? password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ProgressHUD(
        key: UniqueKey(),
        opacity: 0.3,
        inAsyncCall: isAPIcallProcess,
        child: Form(
          key: globalKey,
          child: loginUI(context),
        ),
      ),
    );
  }

  Widget loginUI(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 5,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.pink,
                  Colors.pink,
                ],
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(100),
                bottomRight: Radius.circular(100),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "HeyU",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 4,
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 20,
              bottom: 30,
              top: 50,
            ),
            child: Text(
              "Login",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: Colors.pinkAccent,
              ),
            ),
          ),
          FormHelper.inputFieldWidget(
            context,
            "phoneNumber",
            "Phone Number",
            (onValidateVal) {
              if (onValidateVal.isEmpty) {
                return "Phone number can\'t be empty";
              }
              return null;
            },
            (onSavedVal) {
              phoneNumber = onSavedVal;
            },
            showPrefixIcon: true,
            prefixIcon: const Icon(Icons.call),
            borderFocusColor: Colors.pink,
            prefixIconColor: Colors.pinkAccent,
            borderColor: Colors.pinkAccent,
            textColor: Colors.pinkAccent,
            hintColor: Colors.pinkAccent.withOpacity(0.7),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
            ),
            child: FormHelper.inputFieldWidget(
              context,
              "password",
              "Password",
              (onValidateVal) {
                if (onValidateVal.isEmpty) {
                  return "Password can't be empty";
                }
                return null;
              },
              (onSavedVal) {
                password = onSavedVal;
              },
              showPrefixIcon: true,
              prefixIcon: const Icon(Icons.lock),
              borderFocusColor: Colors.pink,
              prefixIconColor: Colors.pinkAccent,
              borderColor: Colors.pinkAccent,
              textColor: Colors.pinkAccent,
              hintColor: Colors.pinkAccent.withOpacity(0.7),
              obscureText: hidePwd,
              suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      hidePwd = !hidePwd;
                    });
                  },
                  color: Colors.pinkAccent.withOpacity(0.7),
                  icon: Icon(
                    hidePwd ? Icons.visibility_off : Icons.visibility,
                  )),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 25, top: 10),
              child: RichText(
                text: TextSpan(
                  style: TextStyle(
                    color: Colors.pinkAccent,
                    fontSize: 14.5,
                  ),
                  children: [
                    TextSpan(
                        text: "Forget Password?",
                        style: TextStyle(
                          color: Colors.pinkAccent.withOpacity(0.6),
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            print("forget pwd");
                          }),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: FormHelper.submitButton(
              "Login",
              () {},
              btnColor: Colors.white,
              borderColor: Colors.pink,
              txtColor: Colors.pink,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: Text(
              "OR",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18,color: Colors.pink,),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(right: 25, top: 10),
              child: RichText(
                text: TextSpan(
                  style: TextStyle(
                    color: Colors.pinkAccent.withOpacity(0.8),
                    fontSize: 14.5,
                  ),
                  children: [
                    TextSpan(
                      text: "Don't have an account? ",
                    ),
                    TextSpan(
                        text: "Sign up",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (builder)=>const RegistrationScreen()),(route)=>false);

                          }),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
