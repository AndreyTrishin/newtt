import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Discipline extends Equatable {
  String subject;
  String term;
  String type;
  bool isControl;
  Color color;
  List<MLoad> load;

  Discipline(this.subject, this.term, this.type, this.isControl, this.load, this.color);

  @override
  // TODO: implement props
  List<Object> get props => [this.subject, this.term, this.type, this.isControl, this.load, this.color];

  @override
  String toString() {
    return '${this.subject + this.term + this.type + this.isControl.toString()}';
  }


}

class MLoad {
  final String loadName;
  final int amount;

  MLoad(this.loadName, this.amount);
}
