import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

List<Meeting> meetings = [];

/// The hove page which hosts the calendar
class CalendarPage extends StatefulWidget {
  /// Creates the home page to display teh calendar widget.
  const CalendarPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  late CalendarController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Calendar Screen'),
        ),
        body: SfCalendar(
          view: CalendarView.month,
          dataSource: MeetingDataSource(meetings),
          controller: _controller,
          // by default the month appointment display mode set as Indicator, we can
          // change the display mode as appointment using the appointment display
          // mode property
          monthViewSettings: const MonthViewSettings(
              appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
              showAgenda: true),
        ));
  }

  @override
  void initState() {
    _controller = CalendarController();
    getMeets().then((value) {
      setState(() {
        print("set state called");
        super.initState();
      });
    });
  }

  Future<void> getMeets() async {
    final List<Meeting> temp = <Meeting>[];
    final String userId = FirebaseAuth.instance.currentUser!.uid;

    final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('Tasks')
        .where('userId', isEqualTo: userId)
        .where('status', isEqualTo: 'created')
        .get();

    for (final DocumentSnapshot doc in querySnapshot.docs) {
      final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      final String taskText = data['taskText'];
      print("Task Text: $taskText");
      final DateTime start = DateTime.parse(data['start']);
      final DateTime end = DateTime.parse(data['end']);
      final int priority = data['priority'];
      final Color color = priority == 0 ? Colors.green : Colors.red;

      temp.add(Meeting(taskText, start, end, color, false));
    }
    print(temp.length);
    setState(() {
      meetings = temp;
    });
    print(meetings.length);
  }
}

/// An object to set the appointment collection data source to calendar, which
/// used to map the custom appointment data to the calendar appointment, and
/// allows to add, remove or reset the appointment collection.
class MeetingDataSource extends CalendarDataSource {
  /// Creates a meeting data source, which used to set the appointment
  /// collection to the calendar
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return _getMeetingData(index).from;
  }

  @override
  DateTime getEndTime(int index) {
    return _getMeetingData(index).to;
  }

  @override
  String getSubject(int index) {
    return _getMeetingData(index).eventName;
  }

  @override
  Color getColor(int index) {
    return _getMeetingData(index).background;
  }

  @override
  bool isAllDay(int index) {
    return _getMeetingData(index).isAllDay;
  }

  Meeting _getMeetingData(int index) {
    final dynamic meeting = appointments![index];
    late final Meeting meetingData;
    if (meeting is Meeting) {
      meetingData = meeting;
    }

    return meetingData;
  }
}

/// Custom business object class which contains properties to hold the detailed
/// information about the event data which will be rendered in calendar.
class Meeting {
  /// Creates a meeting class with required details.
  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);

  /// Event name which is equivalent to subject property of [Appointment].
  String eventName;

  /// From which is equivalent to start time property of [Appointment].
  DateTime from;

  /// To which is equivalent to end time property of [Appointment].
  DateTime to;

  /// Background which is equivalent to color property of [Appointment].
  Color background;

  /// IsAllDay which is equivalent to isAllDay property of [Appointment].
  bool isAllDay;
}
