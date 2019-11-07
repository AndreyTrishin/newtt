import 'package:equatable/equatable.dart';
import 'package:timetable_app/Models/Universe.dart';

class UniverseState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class UniverseLoading extends UniverseState {}

class UniverseLoaded extends UniverseState {
  final List<Universe> universeList;

  UniverseLoaded(this.universeList);

  @override
  List<Object> get props => universeList;
}

class UniverseNotLoaded extends UniverseState {}
