import 'package:flutter/material.dart';

class MarkRecord {
  String block;
  String subject;
  DateTime date;
  String term;
  String unit;
  String mark;
  String credits;
  String theme;
  int classroomLoad;
  int totalLoad;
  String typeOfTheControl;
  Color color;

  MarkRecord(
      this.block,
      this.subject,
      this.date,
      this.term,
      this.unit,
      this.mark,
      this.credits,
      this.theme,
      this.classroomLoad,
      this.totalLoad,
      this.typeOfTheControl) {
    switch (this.mark) {
      case 'Зачет':
        this.color = Color.fromARGB(255, 240, 250, 241);
        this.mark = 'Зачет';
        break;
      case 'Неудовлетворительно':
        this.color = Colors.red;
        this.mark = '2';
        break;
      case 'Незачет':
        this.color = Colors.red;
        this.mark = 'Незачет';
        break;
      case 'Удовлетворительно':
        this.mark = '3';
        this.color = Color.fromARGB(255, 248, 249, 241);

        break;
      case 'Хорошо':
        this.mark = '4';
        this.color = Color.fromARGB(255, 248, 249, 241);
        break;
      case 'Отлично':
        this.mark = '5';
        this.color = Color.fromARGB(255, 240, 250, 241);
        break;
      default:
        this.color = Colors.white;
        break;
    }
  }
}
