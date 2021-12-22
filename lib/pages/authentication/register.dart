import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:sportal_web_panel/main.dart';
import 'package:sportal_web_panel/pages/authentication/profile.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase/firebase.dart' as fb;
import 'package:firebase/firestore.dart' as fs;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sportal_web_panel/fieldowner.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _RegisterPageState();
  }
}

class _RegisterPageState extends State<RegisterPage> {
  String name = "";
  String phoneNumber = "";
  String password = "";
  String mail = "";
  String adress = "";
  FieldOwner? user;
  late UserCredential userCredential;
  List<bool> days = [true, true, true, true, true, true, true];
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
              Row(
                children: [
                  SizedBox(
                    width: 100,
                  ),
                  Container(
                      width: 400,
                      child: TextField(
                        decoration: InputDecoration(
                            labelText: "İşletme Sahibinin Adı",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20))),
                        onChanged: (text) {
                          name = text;
                        },
                      )),
                  SizedBox(
                    width: 50,
                  ),
                  Container(
                    width: 400,
                    child: TextField(
                      decoration: InputDecoration(
                          labelText: "Telefon Numarası",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20))),
                      onChanged: (text) {
                        phoneNumber = text;
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 100,
                  ),
                  Container(
                      width: 400,
                      child: TextField(
                        decoration: InputDecoration(
                            labelText: "Mail Adresi",
                            hintText: "abc@domain.com",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20))),
                        onChanged: (text) {
                          mail = text;
                        },
                      )),
                  SizedBox(
                    width: 50,
                  ),
                  Container(
                    width: 400,
                    child: TextField(
                      decoration: InputDecoration(
                          labelText: "Şifre",
                          hintText: "123456",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20))),
                      onChanged: (text) {
                        password = text;
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                decoration: InputDecoration(
                    labelText: "Saha Adresi",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100))),
                onChanged: (text) {
                  adress = text;
                },
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    width: 120,
                    child: CheckboxListTile(
                        shape: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        title: Text("Pzt"),
                        controlAffinity: ListTileControlAffinity.platform,
                        activeColor: textBoxColor,
                        checkColor: Colors.white,
                        value: days[0],
                        onChanged: (value) => setState(() => days[0] = value!)),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    width: 120,
                    child: CheckboxListTile(
                        shape: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        title: Text("Sal"),
                        controlAffinity: ListTileControlAffinity.platform,
                        activeColor: textBoxColor,
                        checkColor: Colors.white,
                        value: days[1],
                        onChanged: (value) => setState(() => days[1] = value!)),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    width: 120,
                    child: CheckboxListTile(
                        shape: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        title: Text("Çar"),
                        controlAffinity: ListTileControlAffinity.platform,
                        activeColor: textBoxColor,
                        checkColor: Colors.white,
                        value: days[2],
                        onChanged: (value) => setState(() => days[2] = value!)),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    width: 120,
                    child: CheckboxListTile(
                        shape: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        title: Text("Per"),
                        controlAffinity: ListTileControlAffinity.platform,
                        activeColor: textBoxColor,
                        checkColor: Colors.white,
                        value: days[3],
                        onChanged: (value) => setState(() => days[3] = value!)),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    width: 120,
                    child: CheckboxListTile(
                        shape: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        title: Text("Cum"),
                        controlAffinity: ListTileControlAffinity.platform,
                        activeColor: textBoxColor,
                        checkColor: Colors.white,
                        value: days[4],
                        onChanged: (value) => setState(() => days[4] = value!)),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    width: 120,
                    child: CheckboxListTile(
                        shape: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        title: Text("Cmt"),
                        controlAffinity: ListTileControlAffinity.platform,
                        activeColor: textBoxColor,
                        checkColor: Colors.white,
                        value: days[5],
                        onChanged: (value) => setState(() => days[5] = value!)),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    width: 120,
                    child: CheckboxListTile(
                        shape: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        title: Text("Paz"),
                        controlAffinity: ListTileControlAffinity.platform,
                        activeColor: textBoxColor,
                        checkColor: Colors.white,
                        value: days[6],
                        onChanged: (value) => setState(() => days[6] = value!)),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  if (!controlFields()) {
                    errorDialog(context, "Lütfen Bilgileri Eksiksiz Girin!");
                  } else {
                    signUp(context, mail, password);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => EditProfile()),
                    );
                  }
                },
                child: Container(
                    decoration: BoxDecoration(
                        color: textBoxColor,
                        borderRadius: BorderRadius.circular(20)),
                    alignment: Alignment.center,
                    width: 200,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Text("KAYIT OL")),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void errorDialog(context, String text) {
    showDialog(
      context: context,
      builder: (_) => SimpleDialog(
        title: Text(text),
        children: [
          SimpleDialogOption(
            onPressed: () {
              Navigator.pop(context, "Tamam");
            },
            child: const Text('Tamam'),
          ),
        ],
      ),
      barrierDismissible: true,
    );
  }

  bool controlFields() {
    if (name.isEmpty || phoneNumber.isEmpty || adress.isEmpty || mail.isEmpty) {
      return false;
    }
    return true;
  }

  void initOwner() {
    owner = FieldOwner(mail, password);
    owner!.setAdress(adress);
    owner!.setNum(phoneNumber);
    owner!.setName(name);
    for (int i = 0; i < 7; i++) {
      if (!days[i]) owner!.setDay(i);
    }
  }

  Future<void> signUp(context, email, password) async {
    try {
      userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      initOwner();
      print(userCredential.user!.email);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        errorDialog(context, "Zayıf Şifre!");
      } else if (e.code == 'email-already-in-use') {
        errorDialog(
            context, "Bu mail adresi kullanılarak daha önce kayıt olunmuş");
      }
    } catch (e) {
      print(e);
    }
  }
}
