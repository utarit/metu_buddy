import 'package:flutter/material.dart';
import 'package:metu_helper/models/course_schedule.dart';
import 'package:metu_helper/screens/course_edit_screen.dart';
import 'package:metu_helper/screens/deadline_edit_screen.dart';

class AgendaScreen extends StatefulWidget {
  @override
  _AgendaScreenState createState() => _AgendaScreenState();
}

class _AgendaScreenState extends State<AgendaScreen> {
  Program program;
  List<Deadline> deadlines = [
  Deadline(course: Course(acronym: "PSY100"), endTime: DateTime.utc(2019, 11, 23, 23, 59), description: "PSY some reading some writing bla blaawdawd awdawdawcwadcawdc" ),
];

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
    // setState(() {
    //   program.addCourse(Course(acronym: "CENG400"), 0, 0);
    //   program.addCourse(Course(acronym: "CENG400"), 0, 1);
    //   program.addCourse(Course(acronym: "CENG350"), 1, 0);
    //   program.addCourse(Course(acronym: "CENG350"), 1, 1);
    //   program.addCourse(Course(acronym: "PSY100"), 2, 3);
    //   program.addCourse(Course(acronym: "PSY100"), 2, 4);
    // });

    //draw from local data and make the write to table
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

    Scaffold.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text("$result")));
  }
  _navigateDeadlineEditScreen(BuildContext context) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    final result = await Navigator.push(
      context,
      // Create the SelectionScreen in the next step.
      MaterialPageRoute(builder: (context) => DeadlineEditScreen()),
    );

    if(result != null){
      setState(() {
        deadlines.add(Deadline(course: Course(acronym:  result["course"]), description: result["description"], endTime: result["deadline"]));
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
        Padding(
          padding: EdgeInsets.only(top: 8, left: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Deadlines",
                style: TextStyle(
                    fontFamily: "Galano",
                    fontSize: 23,
                    fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  _navigateDeadlineEditScreen(context);
                },
              )
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: deadlines.length,
            itemBuilder: (context, index) {
              var t = deadlines[index].endTime;
              return Dismissible(
                background: Container(
                  color: Colors.red,
                ),
                key: UniqueKey(),
                child: ListTile(
                  title: Text(deadlines[index].course.acronym),
                  subtitle: Text(deadlines[index].description),
                  trailing: Text("${t.day}/${t.month} ${t.hour}:${t.minute}"),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
