import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
class AllImages extends StatefulWidget {
  const AllImages({super.key});

  @override
  State<AllImages> createState() => _AllImagesState();
}

class _AllImagesState extends State<AllImages> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFFFFFF),
      body: StreamBuilder(
        stream: FirebaseDatabase.instance.ref("post").once().asStream(),
        builder: (context,AsyncSnapshot<dynamic>  snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            DatabaseEvent databaseEvent = snapshot.data!;
            var databaseSnapshot = databaseEvent.snapshot;
            print('Snapshot: ${databaseSnapshot.value}');
            return Text("${databaseSnapshot.value}");
          } else if (!snapshot.hasData) {
    return Center(child: CircularProgressIndicator());
    }
    if (snapshot.hasError) {
    return Text('error',style: TextStyle(color: Colors.purple),);
    }
    if (snapshot.hasData) {
      return
          ListView.builder(
      itemCount: snapshot.data!.docs.length,
    itemBuilder: (BuildContext context, int index) {
        return
            ListTile(
              title: Image.network(src),
            );
    }
          );
    }else{
      return Container();
    }
      }),
    );
  }
}
