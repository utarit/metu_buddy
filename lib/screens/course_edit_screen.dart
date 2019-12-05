import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:metu_buddy/models/course.dart';
import 'package:metu_buddy/utils/common_functions.dart';

class CourseEditScreen extends StatefulWidget {
  final Course course;
  CourseEditScreen({this.course});

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
  int _selectedColor = 0;

  final courseColors = [
    Colors.red.value,
    Colors.purple.value,
    Colors.pink.value,
    Colors.blue.value,
    Colors.green.value,
    Colors.orange.value,
    Colors.cyan.value,
    Colors.indigo.value,
    Colors.lime.value
  ];

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

    if (widget.course != null) {
      for (int i = 0; i < widget.course.hours.length; i++) {
        lessonHours.add(widget.course.hours[i]);
      }
      for (int i = 0; i < 14; i++) {
        syllabusControllerList
            .add(TextEditingController(text: widget.course?.syllabus[i] ?? ""));
      }
      for (int i = 0; i < courseColors.length; i++) {
        if (widget.course.color == courseColors[i]) {
          setState(() {
            _selectedColor = i;
          });
        }
      }
      courseAcronymController.text = widget.course.acronym;
      courseNameController.text = widget.course.fullName;
    } else {
      for (int i = 0; i < 14; i++) {
        syllabusControllerList.add(TextEditingController());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        leading: IconButton(
          color: Colors.black,
          icon: Icon(
            Icons.arrow_back,
            size: 30,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "${widget.course == null ? "Add" : "Edit"} Course",
          style: TextStyle(
            fontFamily: "Galano",
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.done,
              color: Colors.black,
              size: 30,
            ),
            onPressed: () {
              _submitCourse();
            },
          ),
          SizedBox(
            width: 4,
          )
        ],
      ),
      body: Form(
          key: _formKey,
          child: Container(
            padding: EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  widget.course == null
                      ? TextFormField(
                          controller: courseAcronymController,
                          decoration: InputDecoration(
                              labelText: 'Enter Course Acronym'),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter some text';
                            } else if (value.length > 7) {
                              return 'Acronym cannot be longer that 7 character';
                            }
                            return null;
                          },
                        )
                      : Text(
                          widget.course.acronym,
                          style: TextStyle(
                            fontFamily: "Galano",
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                  SizedBox(
                    height: 75,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: courseColors.length,
                      itemBuilder: (context, index) {
                        return FlatButton(
                          padding: EdgeInsets.all(0),
                          onPressed: () {
                            setState(() {
                              _selectedColor = index;
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.all(8),
                            width: 75,
                            decoration: BoxDecoration(
                              border: _selectedColor == index
                                  ? Border.all(color: Colors.black, width: 2)
                                  : Border.all(width: 0),
                              borderRadius: BorderRadius.circular(12),
                              color: Color(courseColors[index]),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  TextFormField(
                    controller: courseNameController,
                    decoration: InputDecoration(labelText: 'Enter Course Name'),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      } else if (value.length > 30) {
                        return 'No more than 30 characters';
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
                ],
              ),
            ),
          )),
    );
  }

  void _submitCourse() async {
    if (_formKey.currentState.validate()) {
      Course result = Course(
          acronym: courseAcronymController.text.toUpperCase(),
          fullName: courseNameController.text,
          hours: lessonHours,
          key: widget.course?.key ??
              DateTime.now().millisecondsSinceEpoch % UPPER_LIMIT,
          color: courseColors[_selectedColor],
          syllabus: syllabusControllerList
              .map((f) => f.text.isEmpty ? "-" : f.text)
              .toList());

      await Hive.openBox("courses");
      Hive.box("courses").put(result.key, result);
      Navigator.pop(context);
      if (widget.course != null) {
        Navigator.pop(context);
      }
    }
  }
}
