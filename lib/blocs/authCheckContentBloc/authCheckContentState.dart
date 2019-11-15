class AuthCheckContentState {}

class AuthCheckContentNotEmpty extends AuthCheckContentState {
  final String university;
  final String name;
  final String password;

  AuthCheckContentNotEmpty(this.university, this.name, this.password);
}

class AuthCheckContentEmpty extends AuthCheckContentState {}
