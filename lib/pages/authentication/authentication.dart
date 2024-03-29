// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables, use_function_type_syntax_for_parameters

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sportal_web_panel/main.dart';
import 'package:sportal_web_panel/pages/authentication/register.dart';
import 'package:sportal_web_panel/pages/authentication/reset.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_web/firebase_auth_web.dart';
import 'package:sportal_web_panel/pages/home/home.dart';
import 'package:sportal_web_panel/pages/schedule/schedule.dart';

class AuthenticationPage extends StatelessWidget {
  String password = "";
  String mail = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          constraints: BoxConstraints(maxWidth: 650),
          padding: EdgeInsets.all(22.5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 0),
                    child: Image.asset("assets/icons/logo.png"),
                  ),
                  Expanded(child: Container()),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 15,
              ),
              TextField(
                decoration: InputDecoration(
                    labelText: "Email",
                    hintText: "abc@domain.com",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
                onChanged: (text) {
                  mail = text;
                },
              ),
              SizedBox(
                height: 15,
              ),
              TextField(
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                decoration: InputDecoration(
                    labelText: "Password",
                    hintText: "123",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
                onChanged: (text) {
                  password = text;
                },
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ResetPassword()),
                            );
                          },
                          child: Text("Forget Password")),
                    ],
                  ),
                  TextButton(
                      onPressed: () {
                        if (sehirler.ilceler.isEmpty) {
                          sehirler.fillSehirs().then((value) => sehirler
                              .fillIlces()
                              .then((value) => sehirler
                                  .fillMahalles()
                                  .then((value) => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                RegisterPage()),
                                      ))));
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegisterPage()),
                          );
                        }
                      },
                      child: Text("Register"))
                ],
              ),
              InkWell(
                onTap: () {
                  signIn(context, mail, password);
                },
                child: Container(
                    decoration: BoxDecoration(
                        color: textBoxColor,
                        borderRadius: BorderRadius.circular(20)),
                    alignment: Alignment.center,
                    width: double.maxFinite,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Text("Login")),
              ),
            ],
          ),
        ),
      ),
    );
  }

  signIn(context, email, password) {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((user) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => TappedAppointment()),
      );
    }).catchError((e) {
      showDialog(
        context: context,
        builder: (_) => SimpleDialog(
          title: Text('Wrong password or mail!'),
          children: [
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, "Ok");
              },
              child: const Text('Ok'),
            ),
          ],
        ),
        barrierDismissible: true,
      );
    });
  }
}
