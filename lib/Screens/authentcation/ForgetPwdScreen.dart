import 'package:flutter/material.dart';
import 'package:heyu_front/Screens/authentcation/ResetPwdScreen.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import '../../Services/auth_service.dart';
import '../../Services/shared_service.dart';
import '../../config.dart';

class ForgetPwd extends StatefulWidget {
  const ForgetPwd({super.key});

  @override
  State<ForgetPwd> createState() => _ForgetPwdState();
}

class _ForgetPwdState extends State<ForgetPwd> {
  bool isAPIcallProcess = false;
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  late String email = "";
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
              "HeyU will send an email with verification code",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: Colors.pinkAccent,
              ),
            ),
          ),
          FormHelper.inputFieldWidget(
            context,
            "email",
            "Email",
            (onValidateVal) {
              if (onValidateVal.isEmpty) {
                return "Email can't be empty";
              }
              return null;
            },
            (onSavedVal) {
              email = onSavedVal;
            },
            showPrefixIcon: true,
            prefixIcon: const Icon(Icons.email),
            borderFocusColor: Colors.pink,
            prefixIconColor: Colors.pinkAccent,
            borderColor: Colors.pinkAccent,
            textColor: Colors.pinkAccent,
            hintColor: Colors.pinkAccent.withOpacity(0.7),
          ),
          const SizedBox(
            height: 50,
          ),
          Center(
            child: FormHelper.submitButton(
              "Send",
              () {
                print(email);

                if (validateAndSave()) {
                  setState(() {
                    isAPIcallProcess = true;
                  });
                  /*FormHelper.showSimpleAlertDialog(
                      context,
                      Config.appName,
                      'Do you confirm sending the verification code to $email !',
                      "Yes", () {*/
                    AuthService.forgetPwd(email).then((response) {
                      setState(() {
                        isAPIcallProcess = false;
                      });
                      if (response) {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (builder) => const ResetPwd()),
                                (route) => false);
                      } else {
                        FormHelper.showSimpleAlertDialog(context,
                            Config.appName, "User dose not exist! ", "OK", () {
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
