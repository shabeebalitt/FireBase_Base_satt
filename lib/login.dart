import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_base/forgot_password.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'flutter_toast.dart';
import 'home.dart';
class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}
bool visible = true;
TextEditingController email = TextEditingController();
TextEditingController password = TextEditingController();
FirebaseAuth auth = FirebaseAuth.instance;
class _LogInState extends State<LogIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff000B17),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            SizedBox(height: 100,),
            Text("Log In",
              style: TextStyle(
                color: Colors.white,
                fontSize: 34,
                fontWeight: FontWeight.w700,
              ),),
            SizedBox(height: 80,),
            Center(
              child: Container(width: 350,
                height: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.blueGrey,
                ),
                child: Column(
                  children: [
                    SizedBox(height: 25,),
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
                    SizedBox(height: 25,),
                    Padding(
                      padding:EdgeInsets.only(right: 220),
                      child: Text("Password",
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
                      child:  Row(
                        children: [
                          Center(
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: 10,
                              ),
                              child: SizedBox(
                                width: 242,
                                child: TextFormField(controller: password,
                                  obscureText: visible,
                                  style: TextStyle(color: Colors.white),
                                  cursorColor: Colors.white,
                                  cursorRadius: Radius.circular(50),
                                  decoration: InputDecoration(
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      hintText: "Password",
                                      hintStyle: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16,
                                          fontFamily: "font1",
                                          fontStyle: FontStyle.normal,
                                          color: Color(0xffA8B1BB))),
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                              onPressed: () => setState(() {
                                visible = !visible;
                              }),
                              icon: visible == false
                                  ? FaIcon(
                                FontAwesomeIcons.eyeSlash,
                                color: Color(0xffA8B1BB),
                                size: 20,
                              )
                                  : FaIcon(
                                FontAwesomeIcons.eye,
                                color: Color(0xffA8B1BB),
                                size: 20,
                              ))
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 215),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => ForgotPassword(),));
                        },
                        child: Text(
                          "Forgot Password?",
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 10,
                              fontFamily: "font1",
                              fontStyle: FontStyle.normal,
                              color: Color(0xffDDE0E3)),
                        ),
                      ),
                    ),
                  ],
                ),),
            ),
            SizedBox(height: 30,),

            GestureDetector(
              onTap: () {
                auth.signInWithEmailAndPassword(
                    email: email.text, password: password.text)
                    .then((value) => {
                  Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext a)=>Home()))
                })
                    .onError((error, stackTrace) => ToastMessage()
                    .toastmessage(message: error.toString()));
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
                    "Log In",
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
