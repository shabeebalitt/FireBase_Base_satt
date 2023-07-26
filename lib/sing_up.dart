import "package:firebase_auth/firebase_auth.dart";
import "package:firebase_base/home.dart";
import "package:firebase_base/login.dart";
import "package:firebase_base/phone_login.dart";
import "package:flutter/material.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import "package:google_sign_in/google_sign_in.dart";

import "flutter_toast.dart";

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

bool visible = true;
TextEditingController email = TextEditingController();
TextEditingController password = TextEditingController();
FirebaseAuth auth = FirebaseAuth.instance;
final GoogleSignIn _googleSignIn = GoogleSignIn();

class _SignUpState extends State<SignUp> {
  Future<String?> signInwithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      await auth
          .signInWithCredential(credential)
          .then((value) { Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => Home(),
              ));
      ToastMessage()
          .toastmessage(message: 'Successfully registerd');
          });
    } on FirebaseAuthException catch (e) {
      ToastMessage()
          .toastmessage(message: e.toString());
      print(e.message);
      throw e;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff000B17),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            SizedBox(
              height: 100,
            ),
            Text(
              "Sign Up",
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
                height: 400,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.blueGrey,
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 25,
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 250),
                      child: Text(
                        "Email",
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
                            controller: email,
                            decoration: InputDecoration(
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                hintText: "Enter here",
                                hintStyle: TextStyle(color: Colors.grey)),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 220),
                      child: Text(
                        "Password",
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
                      child: Row(
                        children: [
                          Center(
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: 10,
                              ),
                              child: SizedBox(
                                width: 242,
                                child: TextFormField(
                                  controller: password,
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
                    SizedBox(
                      height: 40,
                    ),
                    SizedBox(
                        width: 300,
                        child: Divider(
                          color: Colors.grey,
                          height: 1,
                        )),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            signInwithGoogle();
                          },
                          child: Column(
                            children: [
                              FaIcon(
                                FontAwesomeIcons.google,
                                size: 24,
                                color: Colors.amber,
                              ),
                              Text(
                                "Google",
                                style: TextStyle(color: Colors.white),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => PhoneLogIn(),
                            ));
                          },
                          child: Column(
                            children: [
                              FaIcon(
                                FontAwesomeIcons.mobile,
                                size: 24,
                                color: Colors.limeAccent,
                              ),
                              Text(
                                "Number",
                                style: TextStyle(color: Colors.white),
                              )
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () {
                auth
                    .createUserWithEmailAndPassword(
                        email: email.text, password: password.text)
                    .then((value) => {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext a) => LogIn())),
                          ToastMessage()
                              .toastmessage(message: 'Successfully registerd')
                        })
                    .onError((error, stackTrace) =>
                        ToastMessage().toastmessage(message: error.toString()));
              },
              child: Container(
                width: 200,
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.blue),
                child: Center(
                  child: Text(
                    "Sign Up",
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
