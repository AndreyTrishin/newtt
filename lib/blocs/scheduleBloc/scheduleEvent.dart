import 'package:equatable/equatable.dart';

class ScheduleEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class ScheduleLoad extends ScheduleEvent {}

class ScheduleDayChange extends ScheduleEvent{
  final DateTime date;

  ScheduleDayChange(this.date);

  @override
  List<Object> get props => [date];

  @override
  String toString() {
    return 'ScheduleDayChange: {date: $date}';
  }


}