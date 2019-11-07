import 'package:bloc/bloc.dart';
import 'package:timetable_app/APIRequest.dart';
import 'package:timetable_app/Models/User.dart';
import 'package:timetable_app/blocs/scheduleBloc/scheduleEvent.dart';
import 'package:timetable_app/blocs/scheduleBloc/scheduleState.dart';

class ScheduleBloc extends Bloc<ScheduleEvent, ScheduleState>{

  User _user;

  ScheduleBloc(this._user);

  @override
  ScheduleState get initialState => ScheduleLoading();

  @override
  Stream<ScheduleState> mapEventToState(ScheduleEvent event) async* {
    if(event is ScheduleLoad){
      yield ScheduleLoaded(await APIRequest.getSchedule(_user.academicGroupCompoundKey, '2015-09-10'));
    }

  }

}