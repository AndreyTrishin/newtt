import 'package:equatable/equatable.dart';

class PasswordState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class PasswordOpen extends PasswordState {
  final String password;

  PasswordOpen(this.password);
}

class PasswordClose extends PasswordState {
  final String password;

  PasswordClose(this.password);
}

class PasswordEmpty extends PasswordState {}
class PasswordUninitialized extends PasswordState {}
