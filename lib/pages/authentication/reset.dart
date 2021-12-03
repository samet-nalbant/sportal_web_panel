// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:sportal_web_panel/main.dart';

class ResetPassword extends StatelessWidget {
  String mail = "";
  String password = "";
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
              TextField(
                decoration: InputDecoration(
                    labelText: "Password",
                    hintText: "123",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
                onChanged: (text) {
                  mail = text;
                },
              ),
              SizedBox(
                height: 30,
              ),
              InkWell(
                onTap: () {},
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
