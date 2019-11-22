import 'package:flutter/material.dart';
import 'package:metu_helper/models/ring.dart';

class RingWidget extends StatefulWidget {
  @override
  _RingWidgetState createState() => _RingWidgetState();
}

class _RingWidgetState extends State<RingWidget> {
  List<Ring> availableRings;
  TimeOfDay timeNow;

  int totalMin(int hour, int min) => hour * 60 + min;
  String formattedNum(int number) => number < 10 ? "0$number" : "$number";
  TimeOfDay closestRing(index) {
    for (TimeOfDay ringTime in availableRings[index].schedule) {
      if (totalMin(ringTime.hour, ringTime.minute) >=
          totalMin(timeNow.hour, timeNow.minute)) {
        return ringTime;
      }
    }

    return null;
  }

  @override
  void initState() {
    super.initState();
    availableRings = [];
    DateTime now = DateTime.now();
    int day = (now.weekday > 5) ? WeekDay.weekend : WeekDay.weekday;
    timeNow = TimeOfDay.fromDateTime(now);
    for (Ring ring in ringList) {
      if (day == ring.day &&
          totalMin(timeNow.hour, timeNow.minute) <
              totalMin(ring.schedule.last.hour, ring.schedule.last.minute) &&
          totalMin(timeNow.hour + 1, timeNow.minute) >=
              totalMin(ring.schedule.first.hour, ring.schedule.first.minute)) {
        //print(timeNow);
        availableRings.add(ring);
      }
    }
    //print(availableRings);
  }

  @override
  Widget build(BuildContext context) {
    if (availableRings.isEmpty) {
      return Text("Şu an ring yok :(",style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),);
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(availableRings.length, (index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "${availableRings[index].name} - ${formattedNum(closestRing(index)?.hour)}:${formattedNum(closestRing(index)?.minute)}",
                style: TextStyle(fontWeight: FontWeight.w700, color: Colors.white),
              ),
              Text("${availableRings[index].stops.join(" -> ")}", style: TextStyle(fontSize: 12, color: Colors.white60),)
            ],
          );
        }),
      );
    }
  }
}
