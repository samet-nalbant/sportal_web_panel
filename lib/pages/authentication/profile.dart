import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:sportal_web_panel/main.dart';
import 'package:sportal_web_panel/pages/home/home.dart';
import 'package:firebase/firebase.dart' as fb;
import 'package:firebase/firestore.dart' as fs;

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  String properties = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 1024,
          height: 768,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(children: [
                Padding(
                  padding: EdgeInsets.only(left: 234.5, top: 50),
                  child: Image.asset("assets/icons/logo.png"),
                ),
                Expanded(child: Container()),
              ]),
              SizedBox(
                height: 20,
              ),
              Container(
                width: 400,
                child: TextField(
                  decoration: InputDecoration(
                      labelText: "Saha Özellikleri",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100))),
                  onChanged: (text) {
                    properties = text;
                  },
                ),
              ),
              SizedBox(
                height: 100,
              ),
              InkWell(
                onTap: () {
                  uploadStorage();
                },
                child: Container(
                    decoration: BoxDecoration(
                        color: textBoxColor,
                        borderRadius: BorderRadius.circular(20)),
                    alignment: Alignment.center,
                    width: 300,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Text("Upload Foto")),
              ),
              SizedBox(height: 200),
              InkWell(
                onTap: () {
                  owner!.setProperties(properties);
                  addUser();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                },
                child: Container(
                    decoration: BoxDecoration(
                        color: textBoxColor,
                        borderRadius: BorderRadius.circular(20)),
                    alignment: Alignment.center,
                    width: 300,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Text("Profili tamamla")),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void uploadStorage() {
    final dateTime = DateTime.now();
    final userID = FirebaseAuth.instance.currentUser!.uid;
    final path = "$userID/$dateTime";
    uploadImage(onSelected: (file) {
      fb
          .storage()
          .refFromURL("gs://sportalauth.appspot.com")
          .child(path)
          .put(file);
    });
  }

  /*Future<Uri> downloadUrl() {
    return fb
        .storage()
        .refFromURL("gs://sportalauth.appspot.com")
        .child("my pic png")
        .getDownloadURL();
  }*/

  void uploadImage({required Function(File file) onSelected}) {
    var uploadInput = FileUploadInputElement()..accept = 'image/*';
    uploadInput.click();

    uploadInput.onChange.listen((event) {
      final file = uploadInput.files!.first;
      final reader = FileReader();
      reader.readAsDataUrl(file);
      reader.onLoadEnd.listen((event) {
        onSelected(file);
      });
    });
  }

  void addUser() {
    FirebaseFirestore.instance
        .collection("user")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set(owner!.toMap());
  }
}
