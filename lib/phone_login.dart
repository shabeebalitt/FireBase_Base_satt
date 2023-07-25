import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_base/verify_screen.dart';
import 'package:flutter/material.dart';

import 'flutter_toast.dart';
class PhoneLogIn extends StatefulWidget {
  const PhoneLogIn({super.key});

  @override
  State<PhoneLogIn> createState() => _PhoneLogInState();
}
TextEditingController phone = TextEditingController();
FirebaseAuth auth = FirebaseAuth.instance;
class _PhoneLogInState extends State<PhoneLogIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff000B17),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 100,),
            Text("Phone Log In",
              style: TextStyle(
                color: Colors.white,
                fontSize: 34,
                fontWeight: FontWeight.w700,
              ),),
            SizedBox(height: 80,),
            Center(
              child: Container(width: 350,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.blueGrey,
                ),
                child: Column(
                  children: [
                    SizedBox(height: 40,),
                    Padding(
                      padding:EdgeInsets.only(right: 200),
                      child: Text("Phone Number",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),),
                    ),
                    SizedBox(height: 5,),
                    Container(
                      width: 300,
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white12
                      ),
                      child: Center(
                        child: SizedBox(
                          width: 280,
                          child: TextFormField(controller: phone,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                hintText: "Enter here",
                                hintStyle: TextStyle(
                                    color: Colors.grey
                                )
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),),
            ),
            SizedBox(height: 30,),

            GestureDetector(
              onTap: () {
                auth.verifyPhoneNumber(phoneNumber: phone.text,verificationCompleted: (_){},
                    verificationFailed: (e){
                      ToastMessage().toastmessage(message: e.toString());
                    },
                    codeSent: (String verificationId,int? token){
                      Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext a)=>VerifyScreen(verificationId: verificationId,)));

                    },
                    codeAutoRetrievalTimeout: (e){
                      ToastMessage().toastmessage(message: e.toString());
                    });
              },
              child: Container(
                width: 200,
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.blue
                ),
                child: Center(
                  child: Text(
                    "Send OTP",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 20
                    ),
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
