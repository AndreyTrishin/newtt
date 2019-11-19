import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class MainState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class MainCurriculumLoadChange extends MainState {
  final Widget currentWidget;
  final Color color;

  @override
  List<Object> get props => [currentWidget];

  MainCurriculumLoadChange(this.currentWidget, this.color);
}

class MainScheduleChange extends MainState {
  final Widget currentWidget;
  final Color color;

  @override
  List<Object> get props => [currentWidget];

  MainScheduleChange(this.currentWidget, this.color);
}

class MainPerformanceChange extends MainState {
  final Widget currentWidget;
  final Color color;

  @override
  List<Object> get props => [currentWidget];

  MainPerformanceChange(this.currentWidget, this.color);
}

class MainUnitialized extends MainState {}

class DrawerStateChanged extends MainState {}
