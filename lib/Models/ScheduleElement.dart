import 'package:timetable_app/Models/Universe.dart';

class ScheduleElement {
  String date;
  String dayOfWeek;
  List<ScheduleCell> scheduleCell;

  ScheduleElement(this.date, this.dayOfWeek, this.scheduleCell);
}

class ScheduleCell {
  DateTime dateBegin;
  DateTime dateEnd;
  Lesson lesson;

  ScheduleCell(this.dateBegin, this.dateEnd, this.lesson);
}

class Lesson {

  String lessonCompoundKey;
  String subject;
  String lessonType;
  Teacher teacher;
  Classroom classroom;
  String academicGroup;
  Color color;

  Lesson(this.lessonCompoundKey, this.subject, this.lessonType, this.teacher,
      this.classroom, this.academicGroup, this.color);
}

class Classroom {
  String classroomUID;
  String classroomName;

  Classroom(this.classroomUID, this.classroomName);
}

class Teacher {
  String teacherId;
  String teacherName;

  Teacher(this.teacherId, this.teacherName);
}
