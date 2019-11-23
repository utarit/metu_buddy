class Program {
  List<List<Course>> data;
  Program.empty(){
    data = [];
    
    for(int i = 0; i < 9; i++){
      List<Course> tmp = [null, null, null, null, null];
      data.add(tmp);
    }
  }

  void addCourse(Course course, int day, int hour){
    data[hour][day] = course;
  }

  void printTable(){
    for(var row in data){
      print(row);
    }
  }
}
class WorkDay {
  int day;
  List<Course> courses;

  WorkDay(this.day){
    courses = [null,null,null,null,null,null,null,null,null,null];
  }

  WorkDay.fromCourse(this.day, this.courses);
}

class Course {
  String acronym;
  String fullName;
  List<CourseTime> hours;
  List<Deadline> homeworks;

  Course({this.acronym, this.fullName});
}

class CourseTime {
  int hour;
  int day;

  CourseTime({this.day, this.hour});
}

class Deadline {
  Course course;
  DateTime endTime;
  String description;

  Deadline({this.course, this.endTime, this.description});
}

class Homework extends Deadline {
  Homework(): super();
}

class Exam extends Deadline {
  Exam(): super();
}

//Program program = Program.empty();

