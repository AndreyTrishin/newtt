import 'Discipline.dart';

class Group {
  String name;
  List<Semester> listSemester;

  Group(this.name, this.listSemester);
}

class Semester {
  int semester;
  List<Discipline> disciplineList;

  Semester(this.semester, this.disciplineList);
}
