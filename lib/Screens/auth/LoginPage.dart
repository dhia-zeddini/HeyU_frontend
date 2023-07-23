import 'package:flutter/material.dart';
import 'package:heyu_front/Models/CountryModel.dart';
import 'package:heyu_front/Screens/auth/CountryPage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String countryname = "Tunisia";
  String countrycode = "+216";
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Enter your phone number",
          style: TextStyle(
            color: Colors.pink,
            fontWeight: FontWeight.w700,
            fontSize: 20,
            wordSpacing: 1,
          ),
        ),
        centerTitle: true,
        actions: const [
          Icon(
            Icons.more_vert,
            color: Colors.black,
          ),
        ],
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            const Text(
              "HeyU will send an sms message to verify your number",
              style: TextStyle(
                fontSize: 14.5,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            const Text(
              "What's my number?",
              style: TextStyle(fontSize: 13.8, color: Colors.pinkAccent),
            ),
            const SizedBox(
              height: 15,
            ),
            countryCard(),
            const SizedBox(
              height: 5,
            ),
            number(),
            /*SizedBox(
              height: MediaQuery.of(context).size.height / 1.6,
            ),*/
            Expanded(child: Container()),
            InkWell(
              onTap: () {
                showMyDilogue();
              },
              child: Container(
                color: Colors.pink[400],
                height: 40,
                width: 70,
                child: const Center(
                  child: Text(
                    "NEXT",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            )
          ],
        ),
      ),
    );
  }

  Widget countryCard() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (builder) => CountryPage(
                      setCountryData: setCountryData,
                    )));
      },
      child: Container(
        width: MediaQuery.of(context).size.width / 1.5,
        padding: const EdgeInsets.symmetric(vertical: 5),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.pinkAccent,
              width: 1.8,
            ),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Center(
                child: Text(
                  countryname,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
            const Icon(
              Icons.arrow_drop_down,
              color: Colors.pinkAccent,
              size: 28,
            )
          ],
        ),
      ),
    );
  }

  Widget number() {
    return Container(
      width: MediaQuery.of(context).size.width / 1.5,
      height: 38,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            width: 70,
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.pinkAccent,
                  width: 1.8,
                ),
              ),
            ),
            child: Row(
              children: [
                const SizedBox(
                  width: 10,
                ),
                const Text(
                  "+",
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(
                  width: 15,
                ),
                Text(
                  countrycode.substring(1),
                  style: const TextStyle(fontSize: 15),
                )
              ],
            ),
          ),
          const SizedBox(
            width: 30,
          ),
          Container(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.pinkAccent,
                  width: 1.8,
                ),
              ),
            ),
            width: MediaQuery.of(context).size.width / 1.5 - 100,
            child: TextFormField(
              controller: controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(8),
                  hintText: "Phone number"),
            ),
          )
        ],
      ),
    );
  }

  void setCountryData(CountryModel countryModel) {
    setState(() {
      countryname = countryModel.name;
      countrycode = countryModel.code;
    });
    Navigator.pop(context);
  }

  Future<void> showMyDilogue() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "We will be veryfying your Phone Number",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  Text(countrycode + " " + controller.text),
                  const Text(
                    "Is this ok , or would you like to edit the number?",
                    style: TextStyle(
                      fontSize: 13.5,
                    ),
                  )
                ],
              ),
            ),
            actions: [
              TextButton(onPressed: () {}, child: const Text("Edit")),
              TextButton(onPressed: () {}, child: const Text("OK")),
            ],
          );
        });
  }
}
