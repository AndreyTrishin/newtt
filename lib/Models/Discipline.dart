import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Discipline extends Equatable {
  String subject;
  String term;
  String type;
  bool isControl;
  Color color;
  int labHours;
  int lecHours;
  int pracHours;

  Discipline(this.subject, this.term, this.type, this.isControl, this.labHours, this.lecHours, this.pracHours, this.color);

  @override
  // TODO: implement props
  List<Object> get props => [this.subject, this.term, this.type, this.isControl, this.labHours, this.lecHours, this.pracHours, this.color];

  @override
  String toString() {
    return '${this.subject + this.term + this.type + this.isControl.toString() + this.labHours.toString() + this.lecHours.toString() + this.pracHours.toString()}';
  }


}
