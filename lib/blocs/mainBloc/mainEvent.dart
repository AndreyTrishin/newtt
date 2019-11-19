import 'package:equatable/equatable.dart';

class MainEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class MainCurriculumLoadLoad extends MainEvent {}

class MainScheduleLoad extends MainEvent {}

class MainPerformanceLoad extends MainEvent {}

class ChangeDrawerState extends MainEvent {
  final bool pr;

  ChangeDrawerState(this.pr);
}

class MainDefault extends MainEvent{}