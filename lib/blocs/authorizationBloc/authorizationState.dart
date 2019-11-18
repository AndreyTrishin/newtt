import 'package:equatable/equatable.dart';
import 'package:timetable_app/Models/Universe.dart';
import 'package:timetable_app/Models/User.dart';

class AuthorizationState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class AuthorizationUnitialized extends AuthorizationState {}

class AuthorizationLoading extends AuthorizationState {}

class Authorized extends AuthorizationState {
  final User user;

  Authorized(this.user);

  @override
  List<Object> get props {
    return [user];
  }
}

class NotAuthorizated extends AuthorizationState {}

class ChangedUniversity extends AuthorizationState {
  final University university;

  ChangedUniversity(this.university);
}

class CanNotAuth extends AuthorizationState {}
