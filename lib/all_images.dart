import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
class AllImages extends StatefulWidget {
  const AllImages({super.key});

  @override
  State<AllImages> createState() => _AllImagesState();
}
final ref=FirebaseDatabase.instance.ref("post");
class _AllImagesState extends State<AllImages> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFFFFFF),
      body: FirebaseAnimatedList(query:ref,
          defaultChild:CircularProgressIndicator(),      itemBuilder:(context,snapshot,animation,index){
            return Image.network(snapshot.child("title").value.toString());
          }
      )
    );
  }
}
