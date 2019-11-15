class AuthCheckContentEvent {}

class AuthCheckContentChange extends AuthCheckContentEvent {
  final String university;
  final String name;
  final String password;

  AuthCheckContentChange(this.university, this.name, this.password);

}

