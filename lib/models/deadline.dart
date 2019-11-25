import 'package:hive/hive.dart';
import 'package:metu_buddy/models/course.dart';

part 'deadline.g.dart';

@HiveType()
class Deadline {
  @HiveField(0)
  Course course;
  @HiveField(1)
  DateTime endTime;
  @HiveField(3)
  String description;

  Deadline({this.course, this.endTime, this.description});
}