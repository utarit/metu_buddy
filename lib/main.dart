import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:metu_helper/models/course.dart';
import 'package:metu_helper/screens/navigation_screen.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

import 'models/deadline.dart';

void main() async {
  final appDocumentDirectory = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  Hive.registerAdapter(DeadlineAdapter(), 0);
  Hive.registerAdapter(CourseAdapter(), 1);
  Hive.registerAdapter(CourseTimeAdapter(), 2);
  runApp(MyApp());
  }

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: "Roboto"
      ),
      home: NavigationScreen(),
    );
  }
}
