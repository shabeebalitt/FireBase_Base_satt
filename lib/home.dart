import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_base/post_scrren.dart';
import 'package:firebase_base/upload_image.dart';
import 'package:flutter/material.dart';

import 'flutter_toast.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

TextEditingController post = TextEditingController();
final firestore = FirebaseFirestore.instance.collection('Post');

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff000B17),
        body: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 100,
                ),
                Text(
                  "Home",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 34,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  height: 60,
                ),
                Center(
                    child: Container(
                      width: 350,
                      height: 250,
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
                            padding: EdgeInsets.only(right: 190),
                            child: Text(
                              "Enter your Text",
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
                            height: 100,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.white12),
                            child: SizedBox(
                              width: 230,
                              child: TextFormField(
                                textInputAction: TextInputAction.newline,
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                                controller: post,
                                decoration: InputDecoration(
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    hintText: "Enter here",
                                    hintStyle: TextStyle(color: Colors.grey)),
                              ),
                            ),
                          ),
                          SizedBox(height: 30,),
                          GestureDetector(
                            onTap: () {
                              final id = DateTime.now().microsecondsSinceEpoch.toString();
                              firestore
                                  .doc(id)
                                  .set({'title': post.text, 'id': id})
                                  .then((value) =>
                              {ToastMessage().toastmessage(message: 'Post Added')})
                                  .onError((error, stackTrace) =>
                                  ToastMessage().toastmessage(message: error.toString()));
                                },
                            child: Container(
                              width: 200,
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.blue,
                              ),
                              child: Center(
                                child: Text(
                                  "Enter",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20
                                  ),
                                ),
                              ),
                            ),
                          ),

                           ],
                       ),
                    )),
                SizedBox(height: 40,),

                Container(
                  width: 200,
                  height: 50,
                  color: Colors.purple,
                  child: Center(
                    child: Text(
                      'Post',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                SizedBox(
                  height: 60,
                ),
                TextButton(
                    onPressed:
                    () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext a) => Post_screen_firestore())),
                    child: Text(
                      'See All Post',
                      style: TextStyle(
                          color: Colors.purple, fontWeight: FontWeight.w500),
                    )),
                TextButton(
                    onPressed:
                        () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext a) => UploadImage())),
                    child: Text(
                      'Upload Image',
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.w500),
                    )),
              ]),
        ));
  }
}
