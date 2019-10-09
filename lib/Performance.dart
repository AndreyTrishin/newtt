
import 'package:flutter/material.dart';

class Performance{
  String name;
  DateTime date;
  String value;
  Color color;

  Performance(this.name, this.value, this.date){
    switch (this.value) {
      case 'Зачёт':
        this.color = Colors.lightGreenAccent;
        break;
      case '2':
        this.color = Colors.red;
        break;
        case 'Незачёт':
        this.color = Colors.red;
        break;
      case '3':
        this.color = Colors.amber;
        break;
      case '4':
        this.color = Colors.limeAccent;
        break;
      case '5':
        this.color = Colors.lightGreenAccent;
        break;
      default:
        this.color = Colors.white;
        break;
    }
  }
}