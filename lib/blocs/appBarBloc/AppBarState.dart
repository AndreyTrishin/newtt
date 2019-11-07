import 'package:equatable/equatable.dart';

class AppBarState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class AppBarPageChanged extends AppBarState {
  final int newPage;

  AppBarPageChanged(this.newPage);

  @override
  List<Object> get props => [newPage];

  @override
  String toString() => 'AppBarPageChanged: {newPage $newPage}';
}

class AppBarUnitialized extends AppBarState {}
