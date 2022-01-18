import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class AddAppointmentDialog extends StatefulWidget {
  // const ({ Key? key }) : super(key: key);

  @override
  AddAppointmentDialogState createState() => AddAppointmentDialogState();
}

class AddAppointmentDialogState extends State<AddAppointmentDialog> {
  var maskFormatter = new MaskTextInputFormatter(
      mask: '+## (###) ###-##-##', filter: {"#": RegExp(r'[0-9]')});
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late String reservedTime = '';
  bool reservedTimeValidate = false;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.all(10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.close,
                    color: Colors.grey,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.blue)),
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: "İsim",
                      ),
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'Lutfen İsim yaziniz';
                        }
                        return null;
                      },
                      controller: nameController,
                      keyboardType: TextInputType.text,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.blue)),
                    child: TextFormField(
                      inputFormatters: [maskFormatter],
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: "Telefon",
                      ),
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'Lutfen Telefon yaziniz';
                        }
                        return null;
                      },
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 3),
                          child: Row(
                            children: [
                              Radio(
                                value: 'normal',
                                groupValue: reservedTime,
                                onChanged: (value) {
                                  setState(() {
                                    reservedTime = value.toString();
                                  });
                                },
                              ),
                              Text('Normal')
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 3),
                          child: Row(
                            children: [
                              Radio(
                                value: '1 Aylık',
                                groupValue: reservedTime,
                                onChanged: (value) {
                                  setState(() {
                                    reservedTime = value.toString();
                                  });
                                },
                              ),
                              Text('1 Aylık')
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 3),
                          child: Row(
                            children: [
                              Radio(
                                value: '3 Aylık',
                                groupValue: reservedTime,
                                onChanged: (value) {
                                  setState(() {
                                    reservedTime = value.toString();
                                  });
                                },
                              ),
                              Text('3 Aylık')
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 3),
                          child: Row(
                            children: [
                              Radio(
                                value: '6 Aylık',
                                groupValue: reservedTime,
                                onChanged: (value) {
                                  setState(() {
                                    reservedTime = value.toString();
                                  });
                                },
                              ),
                              Text('6 Aylık')
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 3),
                          child: Row(
                            children: [
                              Radio(
                                value: '1 Yıllık',
                                groupValue: reservedTime,
                                onChanged: (value) {
                                  setState(() {
                                    reservedTime = value.toString();
                                  });
                                },
                              ),
                              Text('1 Yıllık')
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  reservedTimeValidate
                      ? Container(
                          child: Text(
                            'lutfen seceneklerden 1 tanesini seciniz',
                            style: TextStyle(color: Colors.red),
                          ),
                        )
                      : Container(),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          child: Text('İptal'),
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              primary: Colors.red,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 20),
                              textStyle: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold)),
                        ),
                        ElevatedButton(
                          child: Text('Onayla'),
                          onPressed: () {
                            if (!_formKey.currentState!.validate()) {
                            } else if (reservedTime == '') {
                              setState(() {
                                reservedTimeValidate = true;
                              });
                            } else {
                              Navigator.pop(context, [
                                nameController.text,
                                phoneController.text,
                                reservedTime
                              ]);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              primary: Colors.green,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 20),
                              textStyle: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
