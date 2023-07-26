import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'flutter_toast.dart';
class UploadImage extends StatefulWidget {
  const UploadImage({super.key});

  @override
  State<UploadImage> createState() => _UploadImageState();
}
File? _image;

final picker = ImagePicker();
DatabaseReference databaseReference = FirebaseDatabase.instance.ref('post');
firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage
    .instance;
class _UploadImageState extends State<UploadImage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
      Color(0xff000B17),
      body: GestureDetector(

        onTap:() {
          getGalleryImage();
        },child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 30,),
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white24
              ),
              child:  _image != null
                  ? ClipRRect(
                borderRadius: BorderRadius.circular(10),
                    child: Image.file(
                _image!.absolute,
                fit: BoxFit.cover,
              ),
                  )
                  : Icon(
                Icons.image,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 30,),
            GestureDetector(
              onTap: () async{
                final id=DateTime.now().microsecondsSinceEpoch.toString();
                firebase_storage.Reference ref = firebase_storage
                    .FirebaseStorage.instance.ref('/foldername/' + id);
                firebase_storage.UploadTask uploadtask=ref.putFile(_image!.absolute);
                await Future.value(uploadtask).then((value)async{
                  var newUrl= await ref.getDownloadURL();
                  print(newUrl.toString());
                  databaseReference.child(id).set({
                    'id':id,
                    'title':newUrl.toString()
                  }).then((value) => ToastMessage().toastmessage(message: 'Uploaded'));
                });


              },
              child: Container(
                width: 150,
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Center(
                  child: Text(
                    "Upload Image",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 18
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 30,),
          ],
        ),
      ),
    );
  }
  Future<void> getGalleryImage() async {
    final pickedFile =
    await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('no image found');
      }
    });
  }
}
