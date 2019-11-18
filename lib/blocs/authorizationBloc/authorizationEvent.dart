import 'package:equatable/equatable.dart';
import 'package:timetable_app/Models/Universe.dart';

class AuthorizationEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class TryAuthorization extends AuthorizationEvent {}

class LoadAuthorization extends AuthorizationEvent {
  final String name, password;

  LoadAuthorization(this.name, this.password);

  @override
  String toString() {
    return 'TryAuthorization';
  }
}

class ErrorAuthorization extends AuthorizationEvent {
  @override
  String toString() {
    return 'ErrorAuthorization';
  }
}

class ChangeUniversity extends AuthorizationEvent{
  final University university;
  final String name, password;

  ChangeUniversity(this.university, this.name, this.password);
}