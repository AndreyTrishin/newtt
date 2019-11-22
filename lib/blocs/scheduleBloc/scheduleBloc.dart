import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:intl/intl.dart';
import 'package:timetable_app/APIRequest.dart';
import 'package:timetable_app/Models/User.dart';
import 'package:timetable_app/blocs/scheduleBloc/scheduleEvent.dart';
import 'package:timetable_app/blocs/scheduleBloc/scheduleState.dart';

class ScheduleBloc extends Bloc<ScheduleEvent, ScheduleState> {
  final User _user;

  ScheduleBloc(this._user);

  @override
  ScheduleState get initialState => ScheduleLoading();

  @override
  Stream<ScheduleState> mapEventToState(ScheduleEvent event) async* {
    if (_user.currentRole == 'Обучающийся') {
      if (event is ScheduleLoad) {
        var se = await APIRequest.getSchedule(_user.academicGroupCompoundKey,
            DateFormat('yyyy-MM-dd').format(event.date));
        yield ScheduleLoaded(se);
      } else if (event is ScheduleDayChange) {
        var se = await APIRequest.getSchedule(_user.academicGroupCompoundKey,
            DateFormat('yyyy-MM-dd').format(event.date));
        yield ScheduleDayChanged(se);
      }
    } else {
      if (event is ScheduleLoad) {
        yield ScheduleLoaded(await APIRequest.getTeacherSchedule(
            _user.id, DateFormat('yyyy-MM-dd').format(DateTime.now())));
      } else if (event is ScheduleDayChange) {
        yield ScheduleDayChanged(await APIRequest.getTeacherSchedule(
            _user.id, event.date.toString().substring(0, 10)));
      }
    }
  }
}
