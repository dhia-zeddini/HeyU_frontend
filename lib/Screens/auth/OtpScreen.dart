import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key, required this.number, required this.countryCode});
  final String number;
  final String countryCode;

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Verify ${widget.countryCode} ${widget.number}",
          style: const TextStyle(color: Colors.pink, fontSize: 17),
        ),
        actions: const [
          Icon(
            Icons.more_vert,
            color: Colors.black,
          ),
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(horizontal: 25 ),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            RichText(
              textAlign: TextAlign.center,
                text: TextSpan(children: [
              const TextSpan(
                  text: "We have sent an SMS with a code to ",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  )),
                  TextSpan(
                      text: "${widget.countryCode} ${widget.number}",
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.bold
                      )),

                  TextSpan(
                      text: " \n Wrong number?",
                      style: TextStyle(
                          color: Colors.pink[300],
                          fontSize: 14.5,
                      )),
            ])),
            const SizedBox(
              height: 15,
            ),
            OTPTextField(
              length: 6,
              width: MediaQuery.of(context).size.width,
              fieldWidth: 30,
              style: const TextStyle(
                  fontSize: 17
              ),
              textFieldAlignment: MainAxisAlignment.spaceAround,
              fieldStyle: FieldStyle.underline,
              onCompleted: (pin) {
                print("Completed: $pin");
              },
            ),
            const SizedBox(
              height: 20,
            ),
             Text(
              "Enter 6-digit code",
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 13.5,
            ),
             ),
             const SizedBox(
              height: 30,
            ),
          bottomButton("Resend SMS", Icons.message),
            const SizedBox(
              height: 12,
            ),
            const Divider(
              thickness: 1.5,
            ),
            const SizedBox(
              height: 12,
            ),
            bottomButton("Call Me", Icons.call),

          ],
        ),
      ),
    );
  }

  Widget bottomButton(String content,IconData iconData){
    return    Row(
      children: [
        Icon(
          iconData,
          color: Colors.pinkAccent,
          size: 24,
        ),
        const SizedBox(
          width: 25,
        ),
        Text(
          content,
          style: const TextStyle(color: Colors.pinkAccent, fontSize: 16),
        ),
      ],
    );
  }
}
