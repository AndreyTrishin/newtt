import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class MainState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class MainCurriculumLoadChange extends MainState {
  final Widget currentWidget;

  @override
  List<Object> get props => [currentWidget];

  MainCurriculumLoadChange(this.currentWidget);
}

class MainScheduleChange extends MainState {
  final Widget currentWidget;

  @override
  List<Object> get props => [currentWidget];

  MainScheduleChange(this.currentWidget);
}

class MainPerformanceChange extends MainState {
  final Widget currentWidget;

  @override
  List<Object> get props => [currentWidget];

  MainPerformanceChange(this.currentWidget);
}

class MainUnitialized extends MainState {}
