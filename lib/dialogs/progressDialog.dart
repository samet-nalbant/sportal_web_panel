import 'package:flutter/material.dart';

progressDialogue(BuildContext context) {
  //set up the AlertDialog
  AlertDialog alert = AlertDialog(
    backgroundColor: Colors.transparent,
    elevation: 0,
    content: Container(
      child: Center(
        child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white)),
      ),
    ),
  );
  showDialog(
    //prevent outside touch
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      //prevent Back button press
      return alert;
    },
  );
}
