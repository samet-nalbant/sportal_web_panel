import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String labelText;
  String hintText = "";
  final Function trigger;
  InputField(
      {Key? key,
      required this.labelText,
      required this.hintText,
      required this.trigger})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
      onChanged: (text) {},
    );
  }
}
