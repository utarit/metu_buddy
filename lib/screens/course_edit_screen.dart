import 'package:flutter/material.dart';

class CourseEditScreen extends StatefulWidget {
  @override
  _CourseEditScreenState createState() => _CourseEditScreenState();
}

class _CourseEditScreenState extends State<CourseEditScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Courses"),
      ),
      body: Center(
        child: RaisedButton(
          child: Text("Yess"),
          onPressed: () {
            Navigator.pop(context, 'Yep!');
          },
        ),
      ),
    );
  }
}
