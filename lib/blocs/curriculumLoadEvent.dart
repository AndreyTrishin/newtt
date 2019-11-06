import 'package:equatable/equatable.dart';

abstract class CurriculumLoadEvent extends Equatable {}

class LoadCurriculumLoad extends CurriculumLoadEvent {
  @override
  String toString() {
    return 'LoadCurriculumLoad';
  }
}
