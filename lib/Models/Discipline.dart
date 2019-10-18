import 'package:flutter/material.dart';

class Discipline {
  String name;
  String type;
  bool work;
  Color color;
  int labHours;
  int lecHours;

  Discipline(this.name, this.type, this.work, this.labHours, this.lecHours) {
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
