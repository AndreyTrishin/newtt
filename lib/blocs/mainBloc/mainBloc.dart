import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:timetable_app/Models/User.dart';
import 'package:timetable_app/Widgets/CurriculumLoad.dart';
import 'package:timetable_app/Widgets/PerformancePage.dart';
import 'package:timetable_app/Widgets/SchedulePage.dart';
import 'package:timetable_app/blocs/mainBloc/mainEvent.dart';
import 'package:timetable_app/blocs/mainBloc/mainState.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  final User _user;

  MainBloc(this._user);

  @override
  // TODO: implement initialState
  MainState get initialState => MainUnitialized();

  @override
  Stream<MainState> mapEventToState(MainEvent event) async* {
    if (event is MainCurriculumLoadLoad) {
      yield MainCurriculumLoadChange(CurriculumLoad(_user), Colors.red);
    } else if (event is MainScheduleLoad){
      yield MainScheduleChange(SchedulePage(_user), Colors.red);
    } else if(event is MainPerformanceLoad){
      yield MainPerformanceChange(PerformancePage(_user), Colors.red);
    }
  }
}
