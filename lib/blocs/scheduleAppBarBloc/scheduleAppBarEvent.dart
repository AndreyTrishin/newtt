import 'package:equatable/equatable.dart';

class ScheduleAppBarEvent extends Equatable{
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class ScheduleAppBarPageChange extends ScheduleAppBarEvent{
  final DateTime newDate;

  ScheduleAppBarPageChange(this.newDate);

  @override
  List<Object> get props {
    return [newDate];
  }

  @override
  String toString() {
    return 'ScheduleAppBarPageChange: {$newDate}';
  }
}