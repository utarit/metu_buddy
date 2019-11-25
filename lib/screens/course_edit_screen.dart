import 'package:flutter/material.dart';
import 'package:metu_helper/models/course.dart';
import 'package:metu_helper/utils/common_functions.dart';

class CourseEditScreen extends StatefulWidget {
  @override
  _CourseEditScreenState createState() => _CourseEditScreenState();
}

class _CourseEditScreenState extends State<CourseEditScreen> {
  final _formKey = GlobalKey<FormState>();
  final courseAcronymController = TextEditingController();
  final courseNameController = TextEditingController();
  List<TextEditingController> syllabusControllerList;
  List<CourseTime> lessonHours;
  int _tmpHour;
  int _tmpDay;


  _showBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext bc) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setModalState) {
            return Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                                Text("Day",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold))
                              ] +
                              days
                                  .map((t) => RadioListTile<int>(
                                        title: Text("${t.text}"),
                                        groupValue: _tmpDay,
                                        value: t.index,
                                        onChanged: (val) {
                                          setModalState(() {
                                            _tmpDay = val;
                                            // print(_tmpDay);
                                          });
                                        },
                                      ))
                                  .toList(),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                                Text("Hour",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold))
                              ] +
                              hours
                                  .map((t) => RadioListTile<int>(
                                        title: Text("${t.text}"),
                                        groupValue: _tmpHour,
                                        value: t.index,
                                        onChanged: (val) {
                                          setModalState(() {
                                            _tmpHour = val;
                                            // print(_tmpHour);
                                          });
                                        },
                                      ))
                                  .toList(),
                        ),
                      ),
                    ],
                  ),
                  RaisedButton(
                    child: Text("Add"),
                    onPressed: () {
                      if (_tmpDay != null && _tmpHour != null) {
                        CourseTime courseTime =
                            CourseTime(day: _tmpDay, hour: _tmpHour);
                        setState(() {
                          lessonHours.add(courseTime);
                        });
                      }

                      Navigator.pop(context);
                    },
                  )
                ],
              ),
            );
          });
        });
  }

  @override
  void initState() {
    super.initState();
    lessonHours = List<CourseTime>();
    syllabusControllerList = List<TextEditingController>();
    for (int i = 0; i < 14; i++) {
      syllabusControllerList.add(TextEditingController());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Courses"),
      ),
      body: Form(
          key: _formKey,
          child: Container(
            padding: EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // Text("Add Course",
                  //     style:
                  //         TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
                  TextFormField(
                    controller: courseAcronymController,
                    decoration:
                        InputDecoration(labelText: 'Enter Course Acronym'),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      } else if (value.length > 7) {
                        return 'Acronym cannot be longer that 7 character';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: courseNameController,
                    decoration: InputDecoration(labelText: 'Enter Course Name'),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      } else if (value.length > 20) {
                        return 'No more than 20 characters';
                      }
                      return null;
                    },
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:
                          List.generate(lessonHours?.length ?? 0, (index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: <Widget>[
                              RichText(
                                text: TextSpan(
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 15),
                                    children: [
                                      TextSpan(
                                          text: "Lesson ${index + 1}: ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      TextSpan(
                                          text:
                                              "${days[lessonHours[index].day - 1].text} ${hours[lessonHours[index].hour].text}"),
                                    ]),
                              ),
                              IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () {
                                  setState(() {
                                    lessonHours.removeAt(index);
                                  });
                                },
                              )
                            ],
                          ),
                        );
                      }),
                    ),
                  ),
                  RaisedButton(
                    child: Text("Add Lesson Hour"),
                    onPressed: () {
                      _showBottomSheet(context);
                    },
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Text("Sylabbus",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  Column(
                    children: List.generate(14, (index) {
                      return TextFormField(
                        // initialValue: "-",
                        controller: syllabusControllerList[index],
                        decoration: InputDecoration(
                            labelText: 'Enter Week ${index + 1}'),
                        validator: (value) {
                          if (value.length > 30) {
                            return 'No more than 30 characters';
                          }
                          return null;
                        },
                      );
                    }),
                  ),
                  RaisedButton(
                    child: Text("Add Course"),
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        Course course = Course(
                            acronym: courseAcronymController.text.toUpperCase(),
                            fullName: courseNameController.text,
                            hours: lessonHours,
                            syllabus: syllabusControllerList
                                .map((f) => f.text.isEmpty ? "-" : f.text)
                                .toList());
                        print(course.syllabus);
                        Navigator.pop(context, course);
                      }
                    },
                  )
                ],
              ),
            ),
          )),
    );
  }
}


