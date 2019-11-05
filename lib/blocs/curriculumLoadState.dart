import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:timetable_app/Models/Discipline.dart';

@immutable
class CurriculumLoadState extends Equatable{
  CurriculumLoadState([List props = const []]) : super(props);
}

class CurriculumLoadLoading extends CurriculumLoadState{

  @override
  String toString() {
    return 'CurriculumLoadLoading';
  }
}

class CurriculumLoadLoaded extends CurriculumLoadState {
  final List<Discipline> disciplines;

  CurriculumLoadLoaded([this.disciplines = const []]) : super([disciplines]);

  @override
  String toString() => 'TodosLoaded { todos: $disciplines }';
}

class CurriculumLoadNotLoaded extends CurriculumLoadState {
  @override
  String toString() => 'CurriculumLoadNotLoaded';
}