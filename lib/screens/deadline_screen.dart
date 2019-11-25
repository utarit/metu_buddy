import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:metu_buddy/models/deadline.dart';
import 'package:metu_buddy/screens/deadline_edit_screen.dart';
import 'package:metu_buddy/utils/common_functions.dart';

class DeadlineScreen extends StatefulWidget {
  @override
  _DeadlineScreenState createState() => _DeadlineScreenState();
}

class _DeadlineScreenState extends State<DeadlineScreen> {
  // List<Deadline> deadlines = [
  //   Deadline(
  //       course: Course(acronym: "Hello"),
  //       description: "You can swipe this to delete it",
  //       endTime: DateTime.now())
  // ];
  _navigateDeadlineEditScreen(BuildContext context) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    final result = await Navigator.push(
      context,
      // Create the SelectionScreen in the next step.
      MaterialPageRoute(builder: (context) => DeadlineEditScreen()),
    );

    if (result != null) {
      Deadline deadline = Deadline(
          course: result["course"],
          description: result["description"],
          endTime: result["deadline"]);
      Hive.box("deadlines").add(deadline);

      // setState(() {
      //   deadlines.add(deadline);
      // });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Hive.openBox("deadlines"),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              !snapshot.hasError) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding:
                      const EdgeInsets.only(left: 10, right: 10, top: 45.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Deadlines",
                        style: TextStyle(
                            fontFamily: "Galano",
                            fontSize: 30,
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
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text("You can swipe to delete",
                      style: TextStyle(color: Colors.black38)),
                ),
                Expanded(
                  child: buildListView(),
                )
              ],
            );
          }

          return Scaffold(body: Center(child: CircularProgressIndicator()));
        });
  }

  ListView buildListView() {
    final deadlinesBox = Hive.box("deadlines");
    return ListView.builder(
      itemCount: deadlinesBox.length,
      itemBuilder: (context, index) {
        final deadline = deadlinesBox.getAt(index) as Deadline;
        var t = deadline.endTime;
        return Dismissible(
          onDismissed: (DismissDirection direction) {
            deadlinesBox.deleteAt(index);
          },
          background: Container(
            color: Colors.red,
          ),
          key: UniqueKey(),
          child: ListTile(
            title: Text(deadline.course.acronym),
            subtitle: Text(deadline.description),
            trailing: Text(
                "${formattedNum(t.day)}/${formattedNum(t.month)} ${formattedNum(t.hour)}:${formattedNum(t.minute)}"),
          ),
        );
      },
    );
  }
}
