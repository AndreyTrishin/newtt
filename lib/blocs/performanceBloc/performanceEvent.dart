import 'package:equatable/equatable.dart';

class PerformanceEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class PerformanceLoad extends PerformanceEvent {

  @override
  String toString() => 'PerformanceLoad';
}

class PerformancePageChange extends PerformanceEvent{

  final int val;

  PerformancePageChange(this.val);

  @override
  String toString() => 'PerformancePageChange';
}
