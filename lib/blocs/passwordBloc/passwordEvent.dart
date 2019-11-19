import 'package:equatable/equatable.dart';

class PasswordEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class PasswordStatusChange extends PasswordEvent {
  final bool status;
  final String password;

  PasswordStatusChange(this.status, this.password);
}
