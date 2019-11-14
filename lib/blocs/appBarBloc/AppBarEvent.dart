import 'package:equatable/equatable.dart';

class AppBarEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class AppBarPageChange extends AppBarEvent {
  final int newPage;
//  final int countPage;

  AppBarPageChange(this.newPage);

  @override
  String toString() => 'AppBarPageChange: {newPage: $newPage}';
}

