// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, deprecated_member_use

import 'dart:convert';
import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:sportal_web_panel/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sportal_web_panel/sehir.dart';

class ResetPassword extends StatelessWidget {
  final firebase_auth = FirebaseAuth.instance;
  String mail = "";
  String password = "";
  List<dynamic> _illerListesi = [];
  List<dynamic> _ilceListesi = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          constraints: BoxConstraints(maxWidth: 600),
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
                height: 30,
              ),
              SizedBox(
                height: 30,
              ),
              InkWell(
                onTap: () {
                  @override
                  Future<void> resetPassword(String email) async {
                    await firebase_auth.sendPasswordResetEmail(email: email);
                  }
                },
                child: Container(
                    decoration: BoxDecoration(
                        color: textBoxColor,
                        borderRadius: BorderRadius.circular(20)),
                    alignment: Alignment.center,
                    width: double.maxFinite,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Text("Reset Password")),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
