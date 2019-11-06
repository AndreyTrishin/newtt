import 'package:equatable/equatable.dart';

abstract class CurriculumLoadEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadCurriculumLoad extends CurriculumLoadEvent {}
