import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'flutter_toast.dart';
class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}
TextEditingController email = TextEditingController();
final auth=FirebaseAuth.instance;
class _ForgotPasswordState extends State<ForgotPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff000B17),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 100,),
            Text("Forgot Password?",
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
                      padding:EdgeInsets.only(right: 250),
                      child: Text("Email",
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
                          child: TextFormField(controller: email,
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
                auth.sendPasswordResetEmail(email: email.text).then((value) {
                  ToastMessage().toastmessage(message: 'password changed successfully');
                }).onError((error, stackTrace){
                  ToastMessage().toastmessage(message: error.toString());
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
                    "Reset",
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
