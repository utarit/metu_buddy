import 'package:flutter/material.dart';
import 'package:metu_helper/models/course_schedule.dart';

class AgendaScreen extends StatefulWidget {
  @override
  _AgendaScreenState createState() => _AgendaScreenState();
}

class _AgendaScreenState extends State<AgendaScreen> {
  List<TableRow> table;

  void generateTable() {
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

    program.addCourse(Course(acronym: "CENG400"), 0, 0);
    program.addCourse(Course(acronym: "CENG400"), 0, 1);
    program.addCourse(Course(acronym: "CENG350"), 1, 0);
    program.addCourse(Course(acronym: "CENG350"), 1, 1);
    program.addCourse(Course(acronym: "PSY100"), 2, 3);
    program.addCourse(Course(acronym: "PSY100"), 2, 4);
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
    setState(() {
      table = programList;
    });
  }

  @override
  void initState() {
    super.initState();
    generateTable();
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
                "Dersleriniz",
                style: TextStyle(
                    fontFamily: "Galano",
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: Icon(Icons.settings),
                onPressed: () => null,
              )
            ],
          ),
        ),
        Table(
            columnWidths: {0: FlexColumnWidth(0.7)},
            //defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            // border: TableBorder.all(),
            children: table),
        Padding(
          padding: EdgeInsets.only(top: 8, left: 8),
          child: Text(
            "Deadlines",
            style: TextStyle(
                fontFamily: "Galano",
                fontSize: 23,
                fontWeight: FontWeight.bold),
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
        )
      ],
    );
  }
}
