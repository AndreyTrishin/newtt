import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:timetable_app/Models/Discipline.dart';

@immutable
abstract class CurriculumLoadState extends Equatable {
  @override
  List<Object> get props => [];
}

class CurriculumLoadUninitialized extends CurriculumLoadState {}

class CurriculumLoadLoading extends CurriculumLoadState {
  @override
  String toString() => 'CurriculumLoadLoading';
}

class CurriculumLoadLoaded extends CurriculumLoadState {
  final List<List<Discipline>> disciplines;

  @override
  List<Object> get props => [disciplines];

  CurriculumLoadLoaded({this.disciplines});

  @override
  String toString() => 'CurriculumLoadLoaded { disciplines: $disciplines }';
}

class CurriculumLoadNotLoaded extends CurriculumLoadState {
  @override
  String toString() => 'CurriculumLoadNotLoaded';
}
