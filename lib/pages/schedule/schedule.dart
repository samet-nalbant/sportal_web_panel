import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:intl/intl.dart';
import 'package:sportal_web_panel/comment.dart';
import 'package:sportal_web_panel/dialogs/addAppointmentDialog.dart';
import 'package:sportal_web_panel/dialogs/addAppointmentSelectedDay.dart';
import 'package:sportal_web_panel/dialogs/errorDialog.dart';
import 'package:sportal_web_panel/dialogs/progressDialog.dart';
import 'package:sportal_web_panel/dialogs/removeAppointmentDialog.dart';
import 'package:sportal_web_panel/models/appointment.dart';
import 'package:sportal_web_panel/pages/authentication/authentication.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:sportal_web_panel/main.dart';

void main() => runApp(TappedAppointment());

class TappedAppointment extends StatefulWidget {
  @override
  CalendarAppointment createState() => CalendarAppointment();
}

class CalendarAppointment extends State<TappedAppointment> {
  late CalendarDataSource _dataSource;

  int startClock = 0;
  int endClock = 0;
  Future getTakvimData() async {
    progressDialogue(context);
    try {
      await FirebaseFirestore.instance
          .collection('sahalar')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get()
          .then((value) async {
        String start = value['start'];
        String end = value['end'];
        String bolunmusStart = start.split(':')[0];
        String bolunmusEnd = end.split(':')[0];
        if (mounted) {
          setState(() {
            if (bolunmusStart.split('')[0] == '0') {
              startClock = int.parse(bolunmusStart.split('')[1]);
            } else {
              startClock = int.parse(bolunmusStart);
            }
            if (bolunmusEnd.split('')[0] == '0') {
              endClock = int.parse(bolunmusEnd.split('')[1]);
            } else {
              endClock = int.parse(bolunmusEnd);
            }
          });
        }
        await FirebaseFirestore.instance
            .collection('appointment')
            .where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
            .get()
            .then((value) {
          if (value.docs.length > 0) {
            for (var i = 0; i < value.docs.length; i++) {
              AppointmentModel appointmentModel = AppointmentModel.fromJson(
                value.docs[i].data() as Map<String, dynamic>,
              );

              DateTime startTime = appointmentModel.startDate;
              DateTime endTime = appointmentModel.endDate;
              // DateTime startTime = DateTime.parse(
              //     appointmentModel.date.toString().split(' ')[0] +
              //         ' ' +
              //         appointmentModel.startClock +
              //         ':00.000');
              // DateTime endTime = DateTime.parse(
              //     appointmentModel.date.toString().split(' ')[0] +
              //         ' ' +
              //         appointmentModel.endClock +
              //         ':00.000');

              int willAdTime = 1;
              if (appointmentModel.reservedTime == '1 Aylık') {
                willAdTime = 4;
              } else if (appointmentModel.reservedTime == '3 Aylık') {
                willAdTime = 12;
              } else if (appointmentModel.reservedTime == '6 Aylık') {
                willAdTime = 24;
              } else if (appointmentModel.reservedTime == '1 Yıllık') {
                willAdTime = 48;
              }

              for (var i = 0; i < willAdTime; i++) {
                try {
                  Duration willAddWeek = Duration(days: 7 * i);
                  print(startTime.add(willAddWeek).toString());
                  print(endTime.add(willAddWeek).toString());
                  Appointment app = Appointment(
                      startTime: startTime.add(willAddWeek),
                      endTime: endTime.add(willAddWeek),
                      subject:
                          '${appointmentModel.name}\n${appointmentModel.phone}',
                      color: Colors.blue);

                  print('Eklendi');
                  setState(() {
                    _dataSource.appointments!.add(app);
                    _dataSource.notifyListeners(
                        CalendarDataSourceAction.add, <Appointment>[app]);
                  });
                } catch (e) {
                  errorDialog(context, "Hata Olustu");
                }
              }
            }
          }
        });

        Navigator.pop(context);
      });
    } catch (e) {
      print('hata');
      print(e);
      Navigator.pop(context);
    }

    // takvim datasini cekiyorum.
  }

  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 250)).then((value) {
      getTakvimData();
    });

    // FirebaseFirestore.instance
    //     .collection("sahalar")
    //     .doc(FirebaseAuth.instance.currentUser!.uid)
    //     .collection("Rewieves")
    //     .doc(FirebaseAuth.instance.currentUser!.uid)
    //     .set(new Comment("SALAM", "12121", 4, "121312adasdsadsads").toMap());
    _dataSource = _getDataSource();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          bottomOpacity: 0.0,
          elevation: 0.0,
          actions: [
            Container(
                child: IconButton(
                  icon: Icon(Icons.person_rounded),
                  iconSize: 20,
                  color: textBoxColor,
                  onPressed: () {},
                ),
                decoration:
                    BoxDecoration(color: color, shape: BoxShape.circle)),
            SizedBox(
              width: 50,
            ),
            Container(
                child: IconButton(
                  icon: Icon(Icons.logout_sharp),
                  iconSize: 20,
                  color: textBoxColor,
                  onPressed: () {
                    signOut();
                  },
                ),
                decoration:
                    BoxDecoration(color: color, shape: BoxShape.circle)),
          ],
        ),
        body: SfCalendar(
          showNavigationArrow: true,
          view: CalendarView.week,
          firstDayOfWeek: 1,
          todayHighlightColor: Colors.red,
          timeSlotViewSettings: TimeSlotViewSettings(
              startHour: startClock.toDouble(), // Saatlerin ayarlanması
              endHour: endClock.toDouble(),
              timeFormat: 'kk:mm'),
          dataSource: _dataSource,
          onLongPress: calendarLongPress,
          onTap: calendarTapped,
        ),
      ),
    );
  }

  void calendarLongPress(CalendarLongPressDetails calendarTapDetails) {
    if (calendarTapDetails.date!.toString().split(' ')[1] == '00:00:00.000') {
      showDialog(
          barrierColor: Colors.black.withOpacity(0.5),
          barrierDismissible: true,
          context: context,
          builder: (
            context,
          ) {
            //return a emty container
            return AddAppointmentSelectedDay();
          }).then((value) async {
        if (value != null && value != false) {
          for (var i = 0; i < 23; i++) {
            AppointmentModel appointmentModel = AppointmentModel(
                // date: calendarTapDetails.date!,
                startDate: calendarTapDetails.date!.add(Duration(hours: i)),
                endDate: calendarTapDetails.date!.add(Duration(hours: i + 1)),
                userId: FirebaseAuth.instance.currentUser!.uid,
                name: 'Dolu',
                phone: 'Dolu',
                reservedTime: 'Normal');
            Appointment app = Appointment(
                startTime: calendarTapDetails.date!.add(Duration(hours: i)),
                endTime: calendarTapDetails.date!.add(Duration(hours: i + 1)),
                subject: 'Dolu\nDolu',
                color: Colors.blue);
            setState(() {
              _dataSource.appointments!.add(app);
              _dataSource.notifyListeners(
                  CalendarDataSourceAction.add, <Appointment>[app]);
            });
            FirebaseFirestore.instance
                .collection('appointment')
                .add(appointmentModel.toJson());
          }
        }
      });
    }
  }

  void calendarTapped(CalendarTapDetails calendarTapDetails) {
    if (calendarTapDetails.targetElement == CalendarElement.agenda ||
        calendarTapDetails.targetElement == CalendarElement.appointment) {
      final Appointment appointment = calendarTapDetails.appointments![0];

      if (appointment != null) {
        showDialog(
            barrierColor: Colors.black.withOpacity(0.5),
            barrierDismissible: true,
            context: context,
            builder: (
              context,
            ) {
              //return a emty container
              return RemoveAppointment();
            }).then((value) async {
          if (value != null && value != false) {
            _dataSource.appointments!
                .removeAt(_dataSource.appointments!.indexOf(appointment));
            _dataSource.notifyListeners(CalendarDataSourceAction.remove,
                <Appointment>[]..add(appointment));
            FirebaseFirestore.instance
                .collection('appointment')
                .where('userId',
                    isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                .where('startDate', isEqualTo: calendarTapDetails.date!)
                .get()
                .then((value) {
              print(value.docs.length);
              if (value.docs.length > 0) {
                value.docs[0].reference.delete();
              }
            });
          }
        });
      }
    } else {
      showDialog(
          barrierColor: Colors.black.withOpacity(0.5),
          barrierDismissible: true,
          context: context,
          builder: (
            context,
          ) {
            //return a emty container
            return AddAppointmentDialog();
          }).then((value) async {
        if (value != null) {
          String name = value[0];
          String phone = value[1];
          String reservedTime = value[2];
          int willAdTime = 1;
          if (reservedTime == '1 Aylık') {
            willAdTime = 4;
          } else if (reservedTime == '3 Aylık') {
            willAdTime = 12;
          } else if (reservedTime == '6 Aylık') {
            willAdTime = 24;
          } else if (reservedTime == '1 Yıllık') {
            willAdTime = 48;
          }
          AppointmentModel appointmentModel = AppointmentModel(
              // date: calendarTapDetails.date!,
              startDate: calendarTapDetails.date!,
              endDate: calendarTapDetails.date!.add(Duration(hours: 1)),
              userId: FirebaseAuth.instance.currentUser!.uid,
              name: name,
              phone: phone,
              reservedTime: reservedTime);

          for (var i = 0; i < willAdTime; i++) {
            try {
              Duration willAddWeek = Duration(days: 7 * i);
              Appointment app = Appointment(
                  startTime: calendarTapDetails.date!.add(willAddWeek),
                  endTime: calendarTapDetails.date!
                      .add(willAddWeek)
                      .add(Duration(hours: 1)),
                  subject: '$name\n$phone',
                  color: Colors.blue);
              setState(() {
                _dataSource.appointments!.add(app);
                _dataSource.notifyListeners(
                    CalendarDataSourceAction.add, <Appointment>[app]);
              });
            } catch (e) {
              errorDialog(context, "Hata Olustu");
            }
          }
          await FirebaseFirestore.instance
              .collection('appointment')
              .add(appointmentModel.toJson());
        }
      });
    }
  }

  _DataSource _getDataSource() {
    List<Appointment> appointments = <Appointment>[];
    /*appointments.add(Appointment(
      startTime: DateTime.now(),
      endTime: DateTime.now().add(Duration(hours: 1)),
      subject: 'Rezerv Edildi',
      color: Colors.green,
    ));*/
    return _DataSource(appointments);
  }

  void signOut() {
    _signOut();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AuthenticationPage()),
    );
  }

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}

class _DataSource extends CalendarDataSource {
  _DataSource(List<Appointment> source) {
    appointments = source;
  }
}
