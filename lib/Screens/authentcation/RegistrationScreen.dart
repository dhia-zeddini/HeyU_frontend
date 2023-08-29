import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:heyu_front/Models/Register_request_model.dart';
import 'package:heyu_front/Screens/authentcation/LoginScreen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import '../../Services/auth_service.dart';
import '../../config.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  bool isAPIcallProcess = false;
  bool hidePwd = true;
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  late String phoneNumber;
  late String password;
  late String firstname;
  late String lastname;
  late String username;
  late String email;
  late String path;
  ImagePicker picker = ImagePicker();
  XFile? file;
  @override
  void initState() {
    // TODO: implement initState
    path = "";
    super.initState();
  }

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
          child: registerUI(context),
        ),
      ),
    );
  }

  Widget registerUI(BuildContext context) {
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
              bottom: 20,
              top: 30,
            ),
            child: Text(
              "Register",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: Colors.pinkAccent,
              ),
            ),
          ),
          Center(
            child: InkWell(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (builder) => bottomSheet(),
                  backgroundColor: Colors.transparent,
                );
              },
              child: CircleAvatar(
                radius: 35,
                backgroundColor: Colors.pinkAccent[200],
                child: Stack(
                  children: [
                    if (file != null) // Display the image if path is not null
                      ClipOval(
                        child: Image.file(
                          File(path),
                          width: 70,
                          height: 70,
                          fit: BoxFit.cover,
                        ),
                      ),
                    if (file ==
                        null) // Display the add photo icon if path is null
                      const Icon(
                        Icons.add_a_photo_outlined,
                        color: Colors.white,
                      ),
                  ],
                ),
              ),
            ),
          ),
          Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width / 2,
                child: FormHelper.inputFieldWidget(
                  context,
                  "firstname",
                  "First Name",
                  (onValidateVal) {
                    if (onValidateVal.isEmpty) {
                      return "First Name can't be empty";
                    }
                    return null;
                  },
                  (onSavedVal) {
                    firstname = onSavedVal;
                  },
                  showPrefixIcon: true,
                  prefixIcon: const Icon(Icons.person),
                  borderFocusColor: Colors.pink,
                  prefixIconColor: Colors.pinkAccent,
                  borderColor: Colors.pinkAccent,
                  textColor: Colors.pinkAccent,
                  hintColor: Colors.pinkAccent.withOpacity(0.7),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 2,
                child: FormHelper.inputFieldWidget(
                  context,
                  "lastname",
                  "Last Name",
                  (onValidateVal) {
                    if (onValidateVal.isEmpty) {
                      return "Last Name can't be empty";
                    }
                    return null;
                  },
                  (onSavedVal) {
                    lastname = onSavedVal;
                  },
                  showPrefixIcon: true,
                  prefixIcon: const Icon(Icons.person),
                  borderFocusColor: Colors.pink,
                  prefixIconColor: Colors.pinkAccent,
                  borderColor: Colors.pinkAccent,
                  textColor: Colors.pinkAccent,
                  hintColor: Colors.pinkAccent.withOpacity(0.7),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: FormHelper.inputFieldWidget(
              context,
              "username",
              "User Name",
              (onValidateVal) {
                if (onValidateVal.isEmpty) {
                  return "User Name can't be empty";
                }
                return null;
              },
              (onSavedVal) {
                username = onSavedVal;
              },
              showPrefixIcon: true,
              prefixIcon: const Icon(Icons.person),
              borderFocusColor: Colors.pink,
              prefixIconColor: Colors.pinkAccent,
              borderColor: Colors.pinkAccent,
              textColor: Colors.pinkAccent,
              hintColor: Colors.pinkAccent.withOpacity(0.7),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: FormHelper.inputFieldWidget(
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
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: FormHelper.inputFieldWidget(
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
              showPrefixIcon: true,
              prefixIcon: const Icon(Icons.call),
              borderFocusColor: Colors.pink,
              prefixIconColor: Colors.pinkAccent,
              borderColor: Colors.pinkAccent,
              textColor: Colors.pinkAccent,
              hintColor: Colors.pinkAccent.withOpacity(0.7),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 10,
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
          const SizedBox(
            height: 20,
          ),
          Center(
            child: FormHelper.submitButton(
              "Register",
              () {
                if (validateAndSave()) {
                  setState(() {
                    isAPIcallProcess = true;
                  });
                  RegisterRequestModel model = RegisterRequestModel(
                    firstName: firstname,
                    lastName: lastname,
                    userName: username,
                    email: email,
                    phoneNumber: phoneNumber,
                    password: password,
                    about: "about",
                  );
                  AuthService.register(model,path).then((response) {
                    setState(() {
                      isAPIcallProcess = false;
                    });
                    if (response.status) {
                      FormHelper.showSimpleAlertDialog(
                          context,
                          Config.appName,
                          "${response.message}. Please login to the account",
                          "OK", () {
                        Navigator.pushNamedAndRemoveUntil(
                            context, '/login', (route) => false);
                      });
                    } else {
                      FormHelper.showSimpleAlertDialog(
                          context, Config.appName, response.message, "OK", () {
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
            height: 10,
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
            height: 10,
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
                      text: "Already have an account? ",
                    ),
                    TextSpan(
                        text: "Sign in",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (builder) => const LoginScreen()),
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
    if (form!.validate() && path != "") {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  bool PwdMatch(String input) {
    final regExp = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{8,}$');
    return regExp.hasMatch(input);
  }

  Widget bottomSheet() {
    return SizedBox(
      height: 200,
      width: MediaQuery.of(context).size.width,
      child: Card(
        margin: const EdgeInsets.all(20),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 25),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  iconCreation(Icons.no_photography, Colors.blue, "None", () {
                    if (file != null && mounted) {
                      setState(() {
                        path = "";
                      });
                    }
                  }),
                  const SizedBox(
                    width: 40,
                  ),
                  iconCreation(Icons.camera_alt, Colors.pink, "Camera", () async{
                    file = await picker.pickImage(source: ImageSource.camera);
                    if (file != null && mounted) {
                      setState(() {
                        path = file!.path;
                      });
                    }
                  }),
                  const SizedBox(
                    width: 40,
                  ),
                  iconCreation(Icons.insert_photo, Colors.purple, "Gallery",
                      () async {
                    file = await picker.pickImage(source: ImageSource.gallery);
                    if (file != null && mounted) {
                      setState(() {
                        path = file!.path;
                      });
                    }
                  }),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget iconCreation(
      IconData icon, Color color, String text, void Function() onTap) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: color,
            radius: 30,
            child: Icon(
              icon,
              size: 29,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            text,
            style: const TextStyle(
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
