import 'package:equatable/equatable.dart';
import 'package:timetable_app/Models/ScheduleElement.dart';

class ScheduleState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class ScheduleUnitialized extends ScheduleState{}

class ScheduleLoading extends ScheduleState{}

class ScheduleLoaded extends ScheduleState{
  final ScheduleElement scheduleElement;

  ScheduleLoaded(this.scheduleElement);

  @override
  List<Object> get props => [scheduleElement];


}

