import 'package:equatable/equatable.dart';
import 'package:timetable_app/Models/MarkRecord.dart';

class PerformanceState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class PerformanceLoading extends PerformanceState {}

class PerformanceLoaded extends PerformanceState{

  final List<List<MarkRecord>> performanceList;

  PerformanceLoaded(this.performanceList);

  @override
  List<Object> get props => performanceList;
}

class PerformanceNotLoaded extends PerformanceState {}
