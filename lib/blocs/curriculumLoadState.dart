import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:timetable_app/Models/Discipline.dart';

@immutable
abstract class CurriculumLoadState extends Equatable {
  CurriculumLoadState([List props = const []]) : super(props);
}

class CurriculumLoadUninitialized extends CurriculumLoadState {}

class CurriculumLoadLoading extends CurriculumLoadState {
  @override
  String toString() => 'CurriculumLoadLoading';
}

class CurriculumLoadLoaded extends CurriculumLoadState {
  final List<Map<String, Discipline>> disciplines;

  CurriculumLoadLoaded(this.disciplines);

  @override
  String toString() => 'CurriculumLoadLoaded { disciplines: $disciplines }';
}

class CurriculumLoadNotLoaded extends CurriculumLoadState {
  @override
  String toString() => 'CurriculumLoadNotLoaded';
}