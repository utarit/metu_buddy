import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class DeadlineEditScreen extends StatefulWidget {
  @override
  _DeadlineEditScreenState createState() => _DeadlineEditScreenState();
}

class _DeadlineEditScreenState extends State<DeadlineEditScreen> {
  final _formKey = GlobalKey<FormState>();
  DateTime deadline;
  final courseNameController = TextEditingController();
  final descriptionController = TextEditingController();
  FocusScopeNode currentFocus;

  String fs(int n) => n < 9 ? "0$n" : "$n";
  String formattedDate(DateTime date) =>
      "${fs(date.day)}/${fs(date.month)} ${fs(date.hour)}:${fs(date.minute)}";

  @override
  void initState() {
    super.initState();
    deadline = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Courses"),
      ),
      body: GestureDetector(
        onTap: () {
          currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  //Text("Course Acroynm"),
                  TextFormField(
                    controller: courseNameController,
                    decoration:
                        InputDecoration(labelText: 'Enter Course Acronym'),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: descriptionController,
                    decoration: InputDecoration(
                        labelText: 'Enter Deadline Description'),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                  Row(
                    children: <Widget>[
                      FlatButton(
                          onPressed: () {
                            DatePicker.showDateTimePicker(context,
                                showTitleActions: true,
                                minTime: DateTime.now(),
                                maxTime: DateTime.utc(
                                    DateTime.now().year + 1, 12, 31, 23, 59),
                                onConfirm: (date) {
                              setState(() {
                                deadline = date;
                              });
                            }, currentTime: DateTime.now());
                          },
                          child: Text(
                            "Choose a deadline",
                            style: TextStyle(color: Colors.blue),
                          )),
                      Text(deadline == null ? "" : formattedDate(deadline))
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: RaisedButton(
                      onPressed: () {
                        // Validate returns true if the form is valid, or false
                        // otherwise.
                        if (_formKey.currentState.validate()) {
                          currentFocus = FocusScope.of(context);

                          if (!currentFocus.hasPrimaryFocus) {
                            currentFocus.unfocus();
                          }
                          Map<String, dynamic> data = {
                            "course": courseNameController.text,
                            "description": descriptionController.text,
                            "deadline": deadline
                          };
                          Future.delayed(const Duration(milliseconds: 100), () {
                            Navigator.pop(context, data);
                          });
                        }
                      },
                      child: Text('Submit'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
