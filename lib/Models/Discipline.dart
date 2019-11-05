import 'package:flutter/material.dart';

class Discipline {
  String subject;
  String term;
  String type;
  bool isControl;
  Color color;
  int labHours;
  int lecHours;
  int pracHours;

  Discipline(this.subject, this.term, this.type, this.isControl, this.labHours, this.lecHours, this.pracHours) {
    switch (this.type) {
      case 'ЭКЗАМЕН':
        this.color = Colors.red;
        break;
      case 'ЗАЧЁТ':
        this.color = Colors.deepPurpleAccent;
        break;
      default:
        this.color = Colors.black;
        break;
    }
  }
}
