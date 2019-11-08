import 'package:equatable/equatable.dart';

class ScheduleAppBarEvent extends Equatable{
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class ScheduleAppBarPageChange extends ScheduleAppBarEvent{
  final int newPage;

  ScheduleAppBarPageChange(this.newPage);

  @override
  List<Object> get props {
    return [newPage];
  }

  @override
  String toString() {
    return 'ScheduleAppBarPageChange: {$newPage}';
  }


}