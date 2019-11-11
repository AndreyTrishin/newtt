import 'package:equatable/equatable.dart';

class ScheduleAppBarState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class ScheduleAppBarDateChanged extends ScheduleAppBarState{
  final DateTime newDate;

  ScheduleAppBarDateChanged(this.newDate);

  @override
  List<Object> get props => [newDate];

  @override
  String toString() => 'ScheduleAppBarDateChanged: {newDate $newDate}';



}


class ScheduleAppBarDateUnitialized extends ScheduleAppBarState {
}