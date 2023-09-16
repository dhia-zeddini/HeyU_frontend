import 'package:flutter/material.dart';
import 'package:heyu_front/Screens/authentcation/LoginScreen.dart';
import 'package:heyu_front/Services/shared_service.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';

import '../../Services/auth_service.dart';
import '../../config.dart';


class ResetPwd extends StatefulWidget {
  const ResetPwd({super.key});

  @override
  State<ResetPwd> createState() => _ResetPwdState();
}

class _ResetPwdState extends State<ResetPwd> {
  bool isAPIcallProcess = false;
  bool hidePwd = true;
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  late String code = "";
  late String newPwd = "";
  late String confirmPwd = "";

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
              "Use the verification code that you received",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: Colors.pinkAccent,
              ),
            ),
          ),
          FormHelper.inputFieldWidget(
            context,
            "code",
            "Verification code",
                (onValidateVal) {
              if (onValidateVal.isEmpty) {
                return "Code can't be empty";
              }
              return null;
            },
                (onSavedVal) {
              code = onSavedVal;
            },
            showPrefixIcon: true,
            prefixIcon: const Icon(Icons.lock),
            borderFocusColor: Colors.pink,
            prefixIconColor: Colors.pinkAccent,
            borderColor: Colors.pinkAccent,
            textColor: Colors.pinkAccent,
            hintColor: Colors.pinkAccent.withOpacity(0.7),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: FormHelper.inputFieldWidget(
              context,
              "newPwd",
              "New Password",
                  (onValidateVal) {
                if (onValidateVal.isEmpty) {
                  return "password can't be empty";
                }
                return null;
              },
                  (onSavedVal) {
                newPwd = onSavedVal;
              },
              showPrefixIcon: true,
              prefixIcon: const Icon(Icons.key),
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

          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: FormHelper.inputFieldWidget(
              context,
              "confirmPwd",
              "Confirm password",
                  (onValidateVal) {
                if (onValidateVal.isEmpty) {
                  return "Email can't be empty";
                }
                return null;
              },
                  (onSavedVal) {
                confirmPwd = onSavedVal;
              },
              showPrefixIcon: true,
              prefixIcon: const Icon(Icons.key),
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
          const SizedBox(
            height: 50,
          ),
          Center(
            child: FormHelper.submitButton(
              "Send",
                  () {


                if (validateAndSave()) {
                  setState(() {
                    isAPIcallProcess = true;
                  });
                  /*FormHelper.showSimpleAlertDialog(
                      context,
                      Config.appName,
                      'Do you confirm sending the verification code to $email !',
                      "Yes", () {*/
                  AuthService.newPwd(code,newPwd,confirmPwd).then((response) {
                    setState(() {
                      isAPIcallProcess = false;
                    });
                    if (response[0]) {
                      FormHelper.showSimpleAlertDialog(context,
                          Config.appName, response[1], "OK", () async{
                            await SharedService.logout(context);
                          });
                    } else {
                      FormHelper.showSimpleAlertDialog(context,
                          Config.appName, response[1], "OK", () {
                            Navigator.pop(context);
                          });
                    }
                  });
                  //});
                }
              },
              btnColor: Colors.white,
              borderColor: Colors.pink,
              txtColor: Colors.pink,
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
