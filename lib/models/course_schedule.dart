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
    data[hour][day-1] = course;
  }

  void printTable(){
    for(var row in data){
      print(row);
    }
  }
}

class Course {
  String acronym;
  String fullName;
  List<CourseTime> hours;
  List<String> syllabus;

  Course({this.acronym, this.fullName, this.hours, this.syllabus});
}

class CourseTime {
  int hour;
  int day;

  CourseTime({this.day, this.hour});
}




