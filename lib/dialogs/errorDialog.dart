import 'package:flutter/material.dart';

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
