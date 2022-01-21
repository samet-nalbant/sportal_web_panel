import 'dart:html';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sportal_web_panel/main.dart';
import 'package:sportal_web_panel/pages/schedule/schedule.dart';
import 'package:firebase/firebase.dart' as fb;
import 'package:image_whisperer/image_whisperer.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  String properties = "";
  String? fee;
  List<DateTime> times = [];
  List<File> files = [];
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
              SizedBox(height: 10),
              Container(
                width: 400,
                child: TextField(
                  decoration: InputDecoration(
                      labelText: "Saatlik Saha Ücretini Girin",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100))),
                  onChanged: (text) {
                    fee = text;
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 100,
                width: 700,
                alignment: Alignment.center,
                child: Row(
                  children: [
                    Expanded(
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: files.length,
                          itemBuilder: (BuildContext ctxt, int Index) {
                            return Stack(
                              children: <Widget>[
                                Image.network(
                                  BlobImage(files[Index]).url!,
                                  width: 100,
                                  height: 100,
                                ),
                                Positioned(
                                  top: 0,
                                  right: 0,
                                  child: GestureDetector(
                                    onTap: () {
                                      files.remove(files[Index]);
                                      setState(() {});
                                    },
                                    child: const Icon(
                                      Icons.delete_sharp,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 100),
              InkWell(
                onTap: () async {
                  setState(() {});
                  await uploadStorage().then((value) => setState(() {}));
                  setState(() {});
                },
                child: Container(
                    decoration: BoxDecoration(
                        color: textBoxColor,
                        borderRadius: BorderRadius.circular(20)),
                    alignment: Alignment.center,
                    width: 300,
                    height: 50,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Text("Upload Foto")),
              ),
              SizedBox(height: 20),
              InkWell(
                onTap: () async {
                  owner!.setProperties(properties);
                  owner!.setCost(fee!);
                  await addPhoto().then((value) => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TappedAppointment()),
                      ));
                },
                child: Container(
                    decoration: BoxDecoration(
                        color: textBoxColor,
                        borderRadius: BorderRadius.circular(20)),
                    alignment: Alignment.center,
                    width: 300,
                    height: 50,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Text("Profili tamamla")),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> uploadStorage() async {
    await uploadImage(onSelected: (file) {
      files.add(file);
      times.add(DateTime.now());
    }).then((value) => setState(() {}));
    setState(() {});
  }

  Future<void> addPhoto() async {
    final userID = FirebaseAuth.instance.currentUser!.uid;
    int index = 0;
    for (var item in files) {
      var temp = times[index];
      final path = "$userID/$temp";
      var temp2 = times[0].toString() + "/";
      await fb
          .storage()
          .refFromURL("gs://sportalauth.appspot.com")
          .child(path)
          .put(item)
          .future
          .then((value) async => owner!
              .addPhoto(await fb
                  .storage()
                  .refFromURL("gs://sportalauth.appspot.com")
                  .child(FirebaseAuth.instance.currentUser!.uid)
                  .child(temp2)
                  .getDownloadURL())
              .then((value) => addUser()))
          .then((value) => setState(() {}));
      index++;
    }
  }

  Future<void> uploadImage({required Function(File file) onSelected}) async {
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
    setState(() {});
  }

  Future<void> addUser() async {
    await FirebaseFirestore.instance
        .collection("sahalar")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set(owner!.toMap());

    await FirebaseFirestore.instance.collection("sahalar")
      ..doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("Rewieves")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set(owner!.toMap2());
  }
}
