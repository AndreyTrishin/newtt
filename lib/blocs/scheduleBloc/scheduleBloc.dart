import 'package:bloc/bloc.dart';
import 'package:timetable_app/APIRequest.dart';
import 'package:timetable_app/Models/ScheduleElement.dart';
import 'package:timetable_app/Models/Universe.dart';
import 'package:timetable_app/Models/User.dart';
import 'package:timetable_app/Widgets/EmptyTTRow.dart';
import 'package:timetable_app/Widgets/TeacherTimetable.dart';
import 'package:timetable_app/Widgets/Timetable.dart';
import 'package:timetable_app/blocs/scheduleBloc/scheduleEvent.dart';
import 'package:timetable_app/blocs/scheduleBloc/scheduleState.dart';

class ScheduleBloc extends Bloc<ScheduleEvent, ScheduleState> {
  final User _user;

  ScheduleBloc(this._user);

  static Widget getWidgetList(ScheduleElement element, User user) {
    int index = 0;
    return ListView(
      children: element.scheduleCell.map((cell) {
        index++;
        if (index < 6) {
          return cell.lesson != null
              ? (user.currentRole == 'Обучающийся' ? Timetable(cell, index) : TeacherTimetable(cell, index))
              : EmptyTTRow(cell, index);
        } else {
          return Container();
        }
      }).toList(),
    );
  }

  @override
  ScheduleState get initialState => ScheduleLoading();

  @override
  Stream<ScheduleState> mapEventToState(ScheduleEvent event) async* {
    if (_user.currentRole == 'Обучающийся') {
      if (event is ScheduleLoad) {
        yield ScheduleLoaded(await APIRequest.getSchedule(
            _user.academicGroupCompoundKey, '2015-09-10'));
      } else if (event is ScheduleDayChange) {
        yield ScheduleDayChanged(await APIRequest.getSchedule(
            _user.academicGroupCompoundKey,
            event.date.toString().substring(0, 10)));
      }
    } else {
      if (event is ScheduleLoad) {
        yield ScheduleLoaded(
            await APIRequest.getTeacherSchedule(_user.id, '2015-09-10'));
      } else if (event is ScheduleDayChange) {
        yield ScheduleDayChanged(await APIRequest.getTeacherSchedule(
            _user.id, event.date.toString().substring(0, 10)));
      }
    }
  }
}
