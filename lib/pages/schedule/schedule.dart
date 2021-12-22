import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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

  @override
  void initState() {
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
            startHour: 12, // Saatlerin ayarlanması
            endHour: 24,
          ),
          dataSource: _dataSource,
          onTap: calendarTapped,
        ),
      ),
    );
  }

  void calendarTapped(CalendarTapDetails calendarTapDetails) {
    Appointment app = Appointment(
        startTime: calendarTapDetails.date!,
        endTime: calendarTapDetails.date!.add(Duration(hours: 1)),
        subject: 'Rezerv Edildi',
        color: Colors.red);
    _dataSource.appointments!.add(app);
    _dataSource
        .notifyListeners(CalendarDataSourceAction.add, <Appointment>[app]);

    //
    if (calendarTapDetails.targetElement == CalendarElement.agenda ||
        calendarTapDetails.targetElement == CalendarElement.appointment) {
      final Appointment appointment = calendarTapDetails.appointments![0];

      if (appointment != null) {
        _dataSource.appointments!
            .removeAt(_dataSource.appointments!.indexOf(appointment));
        _dataSource.notifyListeners(
            CalendarDataSourceAction.remove, <Appointment>[]..add(appointment));
      }
    }
    //
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
