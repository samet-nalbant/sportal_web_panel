import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:sportal_web_panel/main.dart';
import 'package:sportal_web_panel/pages/authentication/profile.dart';
import 'package:sportal_web_panel/fieldowner.dart';
import '../../sehir.dart';

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
  int? index;
  Sehir? _selectedSehir;
  Ilce? _selectedIlce;
  Mahalle? _selectedMahalle;
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                      width: 220,
                      decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.circular(10)),
                      child: DropdownButton<Sehir>(
                        dropdownColor: textBoxColor,
                        hint: Text("İl seçin"),
                        value: _selectedSehir,
                        items: sehirler.namesIl.map((Sehir value) {
                          return DropdownMenuItem<Sehir>(
                            value: value,
                            child: Text(value.sehir_title),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedIlce = null;
                            _selectedSehir = value!;
                            sehirler.getIlces(value.sehir_key);
                          });
                        },
                      )),
                  SizedBox(
                    width: 50,
                  ),
                  Container(
                      width: 220,
                      decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.circular(10)),
                      child: DropdownButton<Ilce>(
                        dropdownColor: textBoxColor,
                        hint: Text("İlce seçin"),
                        value: _selectedIlce,
                        items: sehirler.namesIlce.map((Ilce value) {
                          return DropdownMenuItem<Ilce>(
                            value: value,
                            child: Text(value.ilce_title),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedMahalle = null;
                            _selectedIlce = value!;
                            sehirler.getMahalles(value.ilce_key);
                          });
                        },
                      )),
                  SizedBox(
                    width: 50,
                  ),
                  Container(
                      width: 220,
                      decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.circular(10)),
                      child: DropdownButton<Mahalle>(
                        dropdownColor: textBoxColor,
                        hint: Text("Mahalle seçin"),
                        value: _selectedMahalle,
                        items: sehirler.namesMahalle.map((Mahalle value) {
                          return DropdownMenuItem<Mahalle>(
                            value: value,
                            child: Text(value.mahalle_title),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedMahalle = value!;
                          });
                        },
                      )),
                ],
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
    owner!.setAdress(_selectedSehir!.sehir_title, _selectedIlce!.ilce_title,
        _selectedMahalle!.mahalle_title, adress);
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
