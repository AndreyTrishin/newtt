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
  static Widget currentWidget;

  @override
  // TODO: implement initialState
  MainState get initialState => MainUnitialized();

  @override
  Stream<MainState> mapEventToState(MainEvent event) async* {
    if (event is MainCurriculumLoadLoad) {
      currentWidget = CurriculumLoad(_user);
      yield MainCurriculumLoadChange(currentWidget, Colors.red);
    } else if (event is MainScheduleLoad){
      currentWidget = SchedulePage(_user);
      yield MainScheduleChange(currentWidget, Colors.red);
    } else if(event is MainPerformanceLoad){
      currentWidget = PerformancePage(_user);
      yield MainPerformanceChange(currentWidget, Colors.red);
    } else if(event is ChangeDrawerState){
      yield DrawerStateChanged();
    } else if(event is MainDefault){
      yield MainUnitialized();
    }
  }
}
