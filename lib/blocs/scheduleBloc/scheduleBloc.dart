import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:timetable_app/APIRequest.dart';
import 'package:timetable_app/Models/ScheduleElement.dart';
import 'package:timetable_app/Models/Universe.dart';
import 'package:timetable_app/Models/User.dart';
import 'package:timetable_app/Widgets/EmptyTTRow.dart';
import 'package:timetable_app/Widgets/TeacherTimetable.dart';
import 'package:timetable_app/Widgets/Timetable.dart';
import 'package:timetable_app/blocs/scheduleBloc/scheduleEvent.dart';
import 'package:timetable_app/blocs/scheduleBloc/scheduleState.dart';
import 'package:xml/xml.dart' as xml;

import '../../Query.dart';

class ScheduleBloc extends Bloc<ScheduleEvent, ScheduleState> {
  final User _user;

  ScheduleBloc(this._user);

  static Widget getWidgetList(ScheduleElement element, User user) {
    int index = 0;
    return ScrollConfiguration(
      behavior: null,
      child: ListView(
        children: element.scheduleCell.map((cell) {
          index++;
          if (index < 6) {
            return cell.lesson != null
                ? (user.currentRole == 'Обучающийся'
                    ? Timetable(cell, index)
                    : TeacherTimetable(cell, index, user.currentRole))
                : EmptyTTRow(cell, index);
          } else {
            return Container();
          }
        }).toList(),
      ),
    );
  }

  @override
  ScheduleState get initialState => ScheduleLoading();

  @override
  Stream<ScheduleState> mapEventToState(ScheduleEvent event) async* {
    if (_user.currentRole == 'Обучающийся') {
      if (event is ScheduleLoad) {
        var se = await getSchedule(_user.academicGroupCompoundKey,
            DateFormat('yyyy-MM-dd').format(DateTime.now()));
        yield ScheduleLoaded(se);
      } else if (event is ScheduleDayChange) {

        var se = await getSchedule(_user.academicGroupCompoundKey,
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

  Dio dio = Dio();

  Future<ScheduleElement> getSchedule(key, date) async {
//    var responce = await http.post(APIRequest.server,
//        headers: {
//          'Authorization': 'Basic 0JDQtNC80LjQvdC40YHRgtGA0LDRgtC+0YA6',
//          'Content-Type': 'application/xml',
//        },
//        body: Query.getScheduleQuery(key, date, 'AcademicGroup'));
    dio.clear();

    var responce = await dio.post(
      APIRequest.server,
      data: Query.getScheduleQuery(key, date, 'AcademicGroup'),
    );
    var result = xml.parse(responce.data);

    ScheduleElement scheduleElement;

    List<ScheduleCell> lessonList = [];
    try {
      for (var e in result.findAllElements('m:ScheduleCell')) {
        var lesson = e.findElements('m:Lesson');
        Color color;
        if (lesson.isNotEmpty) {
          switch (e
              .findElements('m:Lesson')
              .first
              .findElements('m:LessonType')
              .first
              .text) {
            case 'Лекции':
              color = Color.fromARGB(255, 0, 164, 116);
              break;
            default:
              color = Color.fromARGB(255, 48, 74, 197);
              break;
          }
//        print(e.findElements('m:Lesson').first.findElements('m:LessonType').first.text);
          lessonList.add(ScheduleCell(
              DateTime.parse(e.findElements('m:DateBegin').first.text),
              DateTime.parse(e.findElements('m:DateEnd').first.text),
              Lesson(
                  e.findAllElements('m:LessonCompoundKey').first.text,
                  e
                      .findElements('m:Lesson')
                      .first
                      .findElements('m:Subject')
                      .first
                      .text,
                  e
                      .findElements('m:Lesson')
                      .first
                      .findElements('m:LessonType')
                      .first
                      .text,
                  Teacher(
                      e
                          .findElements('m:Lesson')
                          .first
                          .findElements('m:Teacher')
                          .first
                          .findElements('m:TeacherId')
                          .first
                          .text,
                      e
                          .findElements('m:Lesson')
                          .first
                          .findElements('m:Teacher')
                          .first
                          .findElements('m:TeacherName')
                          .first
                          .text),
                  e
                          .findElements('m:Lesson')
                          .first
                          .findElements('m:Classroom')
                          .isNotEmpty
                      ? Classroom(
                          e
                              .findElements('m:Lesson')
                              .first
                              .findElements('m:Classroom')
                              .first
                              .findElements('m:ClassroomUID')
                              .first
                              .text,
                          e
                              .findElements('m:Lesson')
                              .first
                              .findElements('m:Classroom')
                              .first
                              .findElements('m:ClassroomName')
                              .first
                              .text)
                      : null,
                  e
                      .findElements('m:Lesson')
                      .first
                      .findAllElements('m:AcademicGroupName')
                      .first
                      .text,
                  color)));
        } else {
          lessonList.add(ScheduleCell(
              DateTime.parse(e.findElements('m:DateBegin').first.text),
              DateTime.parse(e.findElements('m:DateEnd').first.text),
              null));
        }
      }
      scheduleElement = ScheduleElement(
          result
              .findAllElements('m:Day')
              .first
              .findAllElements('m:Date')
              .first
              .text,
          result.findAllElements('m:DayOfWeek').first.text,
          lessonList);
    } catch (_) {
      scheduleElement = ScheduleElement(date, '', null);
    }

    return scheduleElement;
  }
}
