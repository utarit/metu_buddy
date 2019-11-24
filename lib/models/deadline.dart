import 'package:hive/hive.dart';
import 'course_schedule.dart';

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