import 'package:flutter/material.dart';

class RemoveAppointment extends StatelessWidget {
  const RemoveAppointment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        insetPadding: EdgeInsets.zero,
        contentPadding: EdgeInsets.all(10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        content: Container(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  icon: Icon(
                    Icons.close,
                    color: Colors.grey,
                  )),
            ),
            Padding(
                padding: const EdgeInsets.all(10.0),
                child:
                    Text('Bu randevuyu kaldırmak istediğinize emin misiniz?')),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    child: Text('İptal'),
                    onPressed: () {
                      Navigator.pop(context, false);
                    },
                    style: ElevatedButton.styleFrom(
                        primary: Colors.red,
                        padding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                        textStyle: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold)),
                  ),
                  ElevatedButton(
                    child: Text('Onayla'),
                    onPressed: () {
                      Navigator.pop(context, true);
                    },
                    style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        textStyle: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
          ],
        )));
  }
}
