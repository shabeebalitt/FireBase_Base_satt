import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'flutter_toast.dart';
import 'home.dart';

class VerifyScreen extends StatefulWidget {
  final verificationId;

  const VerifyScreen({Key? key, required this.verificationId})
      : super(key: key);

  @override
  State<VerifyScreen> createState() => _VerifyScreenState();
}

TextEditingController verificationcode = TextEditingController();
FirebaseAuth auth = FirebaseAuth.instance;

class _VerifyScreenState extends State<VerifyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff000b17),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 100,
            ),
            Text(
              "Verify",
              style: TextStyle(
                color: Colors.white,
                fontSize: 34,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              height: 80,
            ),
            Center(
              child: Container(
                width: 350,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.blueGrey,
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 40,
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 250),
                      child: Text(
                        "OTP",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      width: 300,
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white12),
                      child: Center(
                        child: SizedBox(
                          width: 280,
                          child: TextFormField(
                            controller: verificationcode,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                hintText: "Enter here",
                                hintStyle: TextStyle(color: Colors.grey)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () async {
                final credentials = PhoneAuthProvider.credential(
                    verificationId: widget.verificationId,
                    smsCode: verificationcode.text);
                try {
                  await auth.signInWithCredential(credentials);
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (BuildContext a) => Home()));
                } catch (e) {
                  ToastMessage().toastmessage(message: e.toString());
                }
              },
              child: Container(
                width: 200,
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.blue),
                child: Center(
                  child: Text(
                    "Verify",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 20),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
