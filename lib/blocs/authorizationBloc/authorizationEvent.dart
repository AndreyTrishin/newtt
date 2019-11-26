import 'package:equatable/equatable.dart';

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
  final String university;
  final String name, password;

  ChangeUniversity(this.university, this.name, this.password);
}