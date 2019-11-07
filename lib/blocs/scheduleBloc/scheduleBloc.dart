import 'package:bloc/bloc.dart';
import 'package:timetable_app/APIRequest.dart';
import 'package:timetable_app/Models/ScheduleElement.dart';
import 'package:timetable_app/Models/Universe.dart';
import 'package:timetable_app/Models/User.dart';
import 'package:timetable_app/Widgets/EmptyTTRow.dart';
import 'package:timetable_app/Widgets/Timetable.dart';
import 'package:timetable_app/blocs/scheduleBloc/scheduleEvent.dart';
import 'package:timetable_app/blocs/scheduleBloc/scheduleState.dart';

class ScheduleBloc extends Bloc<ScheduleEvent, ScheduleState>{

  User _user;

  ScheduleBloc(this._user);


  Widget getWidgetList(ScheduleElement element){
    int i = 0;
    return ListView(children: element.scheduleCell.map((cell){
        i++;
        return cell.lesson != null ? Timetable(cell, i) : EmptyTTRow(cell, i);
      }).toList(),);
  }

  @override
  ScheduleState get initialState => ScheduleLoading();

  @override
  Stream<ScheduleState> mapEventToState(ScheduleEvent event) async* {
    if(event is ScheduleLoad){
      yield ScheduleLoaded(await APIRequest.getSchedule(_user.academicGroupCompoundKey, '2015-09-10'));
    }

  }

}