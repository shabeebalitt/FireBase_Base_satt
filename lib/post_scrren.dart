import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'flutter_toast.dart';
class Post_screen_firestore extends StatefulWidget {
  const Post_screen_firestore({super.key});

  @override
  State<Post_screen_firestore> createState() => _Post_screen_firestoreState();
}

final firestore = FirebaseFirestore.instance.collection('Post').snapshots();
final ref = FirebaseFirestore.instance.collection('Post');

class _Post_screen_firestoreState extends State<Post_screen_firestore> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff000B17),
      body:
      StreamBuilder<QuerySnapshot>(
        stream: firestore,
        builder:
            (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Text('error',style: TextStyle(color: Colors.purple),);
          }
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(snapshot.data!.docs[index]['title'].toString(),
                  style: TextStyle(color: Colors.white),),
                  leading: TextButton(
                      onPressed: () {
                        dialogBox(index: index, id: snapshot.data!.docs[index]
                            .id.toString(),  snapshot: snapshot);
                      },
                      child: Text(
                        'Update',
                        style: TextStyle(
                          color: Colors.purple,
                        ),
                      )),
                  trailing: TextButton(
                      onPressed: () {
                        ref.doc(snapshot.data!.docs[index]['id'].toString()).delete();
                      },
                      child: Text(
                        'Delete',
                        style: TextStyle(
                          color: Colors.purple,
                        ),
                      )),
                );
              },
            );
          } else {
            return Container();
          }
        },
      ));
  }

  Future<void> dialogBox({required int index,
    required String id,
    required AsyncSnapshot<QuerySnapshot> snapshot}) async {
    final newValue = TextEditingController();
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'Update',
              style:
              TextStyle(color: Colors.purple, fontWeight: FontWeight.w500),
            ),
            content: TextFormField(
              controller: newValue,
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    ref
                        .doc(snapshot.data!.docs[index]['id'].toString())
                        .update({
                      'title': newValue.text,
                    }).then((value) {
                      ToastMessage()
                          .toastmessage(message: 'Updated Successfully');
                      Navigator.of(context).pop();
                    }).onError((error, stackTrace) {
                      ToastMessage().toastmessage(message: error.toString());
                    });
                  },
                  child: Text(
                    'Update',
                    style: TextStyle(
                        color: Colors.purple, fontWeight: FontWeight.w500),
                  )),
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                        color: Colors.purple, fontWeight: FontWeight.w500),
                  )),
            ],
          );
        });
  }
}
