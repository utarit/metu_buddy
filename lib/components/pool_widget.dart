import 'package:flutter/material.dart';

class PoolWidget extends StatefulWidget {
  @override
  _PoolWidgetState createState() => _PoolWidgetState();
}

class _PoolWidgetState extends State<PoolWidget> {
  List<TimeOfDay> sessions;
  DateTime timeNow;
  TimeOfDay nextSession;

  @override
  void initState() {
    super.initState();
    timeNow = DateTime.now();
    sessions = [
      TimeOfDay(hour: 9, minute: 0),
      TimeOfDay(hour: 10, minute: 30),
      TimeOfDay(hour: 12, minute: 0),
      TimeOfDay(hour: 13, minute: 30),
      TimeOfDay(hour: 15, minute: 0),
      TimeOfDay(hour: 16, minute: 30),
      TimeOfDay(hour: 18, minute: 0),
      TimeOfDay(hour: 19, minute: 30),
    ];
    closestSession();
  }

  int totalMin(int hour, int min) => hour * 60 + min;
  String formattedNum(int number) => number < 10 ? "0$number" : "$number";
  void closestSession() {
    //print(timeNow.hour);
    for (TimeOfDay session in sessions) {
      if (totalMin(session.hour, session.minute) >=
          totalMin(timeNow.hour, timeNow.minute)) {
        nextSession = session;
        return;
      }
    }

    nextSession = null;
    return;
  }

  @override
  Widget build(BuildContext context) {
    return nextSession == null
        ? Text(
            "Havuz şu an genel kullanıma açık değil :|",
            style: TextStyle(color: Colors.white),
          )
        : Text(
            "Sonraki Seans: ${formattedNum(nextSession.hour)}:${formattedNum(nextSession.minute)}",
            style: TextStyle(color: Colors.white),
          );
  }
}
