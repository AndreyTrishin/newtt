import 'package:equatable/equatable.dart';
import 'package:timetable_app/Models/Universe.dart';

class UniversityState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class UniversityLoading extends UniversityState {}

class UniversityLoaded extends UniversityState {
  final List<University> universityList;

  UniversityLoaded(this.universityList);

  @override
  List<Object> get props => universityList;
}

class UniversityNotLoaded extends UniversityState {}
