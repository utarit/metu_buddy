import 'package:flutter/material.dart';
import 'package:metu_helper/models/course_schedule.dart';
import 'package:metu_helper/models/deadline.dart';
import 'package:metu_helper/screens/course_edit_screen.dart';
import 'package:metu_helper/utils/common_functions.dart';

class AgendaScreen extends StatefulWidget {
  @override
  _AgendaScreenState createState() => _AgendaScreenState();
}

class _AgendaScreenState extends State<AgendaScreen> {
  Program program;
  List<Course> courseList;
  List<Deadline> deadlines = [];

  List<TableRow> generateTable() {
    List<TableRow> programList = [
      TableRow(
        decoration: BoxDecoration(
          color: Colors.red[900],
          //borderRadius: BorderRadius.vertical(top: Radius.circular(8.0)),
        ),
        children: ["X", "Mon", "Tue", "Wed", "Thur", "Fri"]
            .map((day) => Container(
                  decoration: BoxDecoration(
                      border: Border(
                          right: day == "X"
                              ? BorderSide(width: 1)
                              : BorderSide.none)),
                  padding: const EdgeInsets.symmetric(
                      vertical: 4.0, horizontal: 2.0),
                  child: Center(
                      child: Text(
                    day,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  )),
                ))
            .toList(),
      )
    ];

    for (int hour = 0; hour < 9; hour++) {
      TableRow row = TableRow(
          decoration: BoxDecoration(
              color: hour % 2 == 0 ? Colors.white : Colors.lightBlue[200]),
          children: [
            Container(
              padding: const EdgeInsets.all(4.0),
              alignment: Alignment.centerRight,
              decoration:
                  BoxDecoration(border: Border(right: BorderSide(width: 1))),
              child: Text("${hour + 8}:40"),
            )
          ]);

      for (int i = 0; i < program.data[hour].length; i++) {
        Course f = program.data[hour][i];
        if (f != null) {
          row.children.add(Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(4.0),
            // decoration: BoxDecoration(color: DateTime.now().weekday == i ? Colors.yellow : Colors.white),
            child: Text(f.acronym, style: TextStyle(fontSize: 12)),
          ));
        } else {
          row.children.add(Container(
              // padding: const EdgeInsets.all(4.0),
              // child: Text(""),
              ));
        }
      }
      programList.add(row);
    }
    return programList;
  }

  @override
  void initState() {
    super.initState();
    program = Program.empty();
    courseList = List<Course>();
    generateTable();
  }

  _navigateEditScreen(BuildContext context) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    final result = await Navigator.push(
      context,
      // Create the SelectionScreen in the next step.
      MaterialPageRoute(builder: (context) => CourseEditScreen()),
    );

    if (result != null) {
      for (CourseTime time in result.hours) {
        if (program.data[time.hour][time.day - 1] == null) {
          program.addCourse(result, time.day, time.hour);
        }
      }
      setState(() {
        courseList.add(result);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 32, bottom: 16, left: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Schedule",
                style: TextStyle(
                    fontFamily: "Galano",
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: Icon(Icons.settings),
                onPressed: () {
                  _navigateEditScreen(context);
                },
              )
            ],
          ),
        ),
        Table(
            columnWidths: {0: FlexColumnWidth(0.7)},
            //defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            // border: TableBorder.all(),
            children: generateTable()),
        Text("Course List"),
        Expanded(
          child: ListView.builder(
            itemCount: courseList.length,
            itemBuilder: (BuildContext context, int index) {
              Duration duration = DateTime.now().difference(schoolStarted);
              int ind = (duration.inDays ~/ 7);
              return ListTile(
                // onTap: (){
                //   CourseEditScreen(courseList[index]);
                // },
                title: Text(courseList[index].acronym),
                subtitle:
                    Text("Week ${ind + 1}: ${courseList[index].syllabus[ind]}"),
              );
            },
          ),
        )
      ],
    );
  }
}
