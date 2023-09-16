import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:heyu_front/Models/Login_request_model.dart';
import 'package:heyu_front/Screens/HomeScreen.dart';
import 'package:heyu_front/Screens/authentcation/ForgetPwdScreen.dart';
import 'package:heyu_front/Screens/authentcation/RegistrationScreen.dart';
import 'package:heyu_front/Services/auth_service.dart';
import 'package:heyu_front/Services/shared_service.dart';
import 'package:heyu_front/config.dart';
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
            child: const Column(
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
          const Padding(
            padding: EdgeInsets.only(
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
                return "Phone number can't be empty";
              }
              return null;
            },
            (onSavedVal) {
              phoneNumber = onSavedVal;
            },
            isNumeric: true,
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
                    hidePwd ?  Icons.visibility: Icons.visibility_off,
                  )),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 25, top: 10),
              child: RichText(
                text: TextSpan(
                  style: const TextStyle(
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
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (builder) =>
                                    const ForgetPwd()),
                                    (route) => false);
                          }),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          Center(
            child: FormHelper.submitButton(
              "Login",
              () {
                if (validateAndSave()) {
                  setState(() {
                    isAPIcallProcess = true;
                  });
                  LoginRequestModel model = LoginRequestModel(
                      phoneNumber: phoneNumber!, password: password!);
                  AuthService.login(model).then((response) {
                    SharedService.onUserLogin();
                    setState(() {
                      isAPIcallProcess = false;
                    });
                    if (response) {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (builder) => const HomeScreen()),
                              (route) => false);
                    } else {
                      FormHelper.showSimpleAlertDialog(context, Config.appName,
                          "Invalid Phone number or Password! ", "OK", () {
                        Navigator.pop(context);
                      });
                    }
                  });
                }
              },
              btnColor: Colors.white,
              borderColor: Colors.pink,
              txtColor: Colors.pink,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Center(
            child: Text(
              "OR",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.pink,
              ),
            ),
          ),
          const SizedBox(
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
                    const TextSpan(
                      text: "Don't have an account? ",
                    ),
                    TextSpan(
                        text: "Sign up",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (builder) =>
                                        const RegistrationScreen()),
                                (route) => false);
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

  bool validateAndSave() {
    final form = globalKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

}
