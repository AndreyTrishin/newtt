import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:timetable_app/Models/User.dart';
import 'package:timetable_app/Widgets/EmptyDayWidget.dart';
import 'package:timetable_app/Widgets/LoadWidget.dart';
import 'package:timetable_app/blocs/scheduleAppBarBloc/ScheduleAppBarBloc.dart';
import 'package:timetable_app/blocs/scheduleAppBarBloc/ScheduleAppBarState.dart';
import 'package:timetable_app/blocs/scheduleAppBarBloc/scheduleAppBarEvent.dart';
import 'package:timetable_app/blocs/scheduleBloc/scheduleBloc.dart';
import 'package:timetable_app/blocs/scheduleBloc/scheduleEvent.dart';
import 'package:timetable_app/blocs/scheduleBloc/scheduleState.dart';

class SchedulePage extends StatelessWidget {
  User _user;

  SchedulePage(this._user);

  PageController _controller = PageController(initialPage: 5000);

  ScheduleBloc _scheduleBloc;
  int currentDay = 5000;
  int day = 0;

  int pageNumber = 1;
  ScheduleAppBarBloc _appBarBloc;
  String currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

  Map<int, String> dayMap = {
    1: 'Понедельник',
    2: 'Вторник',
    3: 'Среда',
    4: 'Четверг',
    5: 'Пятница',
    6: 'Суббота',
    7: 'Воскресенье'
  };

  @override
  Widget build(BuildContext context) {
    _appBarBloc = ScheduleAppBarBloc();
    _scheduleBloc = ScheduleBloc(_user);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 255, 217, 122),
        leading: Container(
          child: FlatButton(
            child: Icon(Icons.dehaze),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
        title: Row(
          children: <Widget>[
            Container(
              width: ScreenUtil.getInstance().setWidth(120),
              child: FlatButton(
                shape: CircleBorder(),
                child: Icon(Icons.chevron_left),
                onPressed: () {
                  _controller.previousPage(
                      duration: Duration(milliseconds: 150),
                      curve: Curves.linear);
                },
              ),
            ),
            Container(
              width: ScreenUtil.getInstance().setWidth(500),
              child: BlocBuilder(
                bloc: _appBarBloc,
                builder: (context, state) {
                  print(state);
                  if (state is ScheduleAppBarDateUnitialized) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          dayMap[DateTime.now().weekday],
                          style: TextStyle(color: Colors.black),
                        ),
                        Text(
                          DateFormat('dd.MM').format(DateTime.now()),
                          style: TextStyle(fontSize: 13, color: Colors.black),
                        ),
                      ],
                    );
                  } else if (state is ScheduleAppBarDateChanged) {
//                    currentDate =
//                        DateFormat('yyyy-MM-dd').format(state.newDate);

                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          dayMap[state.newDate.weekday],
                          style: TextStyle(color: Colors.black),
                        ),
                        Text(
                          DateFormat('dd.MM').format(state.newDate),
                          style: TextStyle(fontSize: 13, color: Colors.black),
                        ),
                      ],
                    );
                  } else {
                    return Text('Ошибка');
                  }
                },
              ),
            ),
            Container(
              width: ScreenUtil.getInstance().setWidth(120),
              child: FlatButton(
                shape: CircleBorder(),
                child: Icon(Icons.chevron_right),
                onPressed: () {
                  _controller.nextPage(
                      duration: Duration(milliseconds: 150),
                      curve: Curves.linear);
                },
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: Container(
                  width: ScreenUtil.getInstance().setWidth(120),
                  child: FlatButton(
                    shape: CircleBorder(),
                    child: Icon(Icons.event),
                    onPressed: () async {
                      try {
                        DateTime date = await showDatePicker(
                            context: context,
                            initialDate: DateTime.parse(currentDate),
                            firstDate: DateTime(2015),
                            lastDate: DateTime(2021));
                        if (date != null) {
                          currentDate = DateFormat('yyyy-MM-dd').format(date);

                          _scheduleBloc.add(ScheduleDayChange(date));
                          _appBarBloc..add(ScheduleAppBarPageChange(date));
                        }
                      } catch (_) {}
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      //todo: При быстрой прокрутке страниц загрузка предыдущих дней не останавливается и отображение нарушается
      body: Container(
          margin: EdgeInsets.fromLTRB(
              0, ScreenUtil.getInstance().setHeight(30), 0, 0),
          child: BlocBuilder(
            bloc: _scheduleBloc..add(ScheduleLoad()),
            builder: (context, state){
              if(state is ScheduleLoading){
                return LoadWidget();
              } else{
                return ScrollConfiguration(
                  behavior: ScrollBehavior(),
                  child: PageView.builder(

                    onPageChanged: (value){
                      day = value < currentDay ? day - 1 : day + 1;
                      currentDay = value;
                      _scheduleBloc..add(ScheduleDayChange(DateTime.now().add(Duration(days: day))));
                      _appBarBloc..add(ScheduleAppBarPageChange(DateTime.now().add(Duration(days: day))));
                    },
                    itemBuilder: (context, index) {
                      return BlocBuilder(
                        bloc: _scheduleBloc,
                        builder: (context, state){
                          if(state is ScheduleLoaded && index == 5000){
                            return state.scheduleElement.scheduleCell != null
                                ? ScheduleBloc.getWidgetList(
                                state.scheduleElement, _user)
                                : EmptyDayWidget();
                          } else if(state is ScheduleDayChanged && index == currentDay){
                            return state.scheduleElement.scheduleCell != null
                                ? ScheduleBloc.getWidgetList(
                                state.scheduleElement, _user)
                                : EmptyDayWidget();
                          } else {
                            return LoadWidget();
                          }
                        },
                      );
                    },
                    controller: _controller,
                  ),
                );
              }
            },
          )
//        BlocBuilder(
//          bloc: _scheduleBloc..add(ScheduleLoad()),
//          builder: (context, state) {
//            if (state is ScheduleLoading) {
//              return LoadWidget();
//            } else if (state is ScheduleLoaded) {
//              return PageView.builder(
//                onPageChanged: (value) {
//                  day = value < currentDay ? day - 1 : day + 1;
//                  currentDay = value;
//
//                  _scheduleBloc.add(ScheduleDayChange(
//                      DateTime.parse(currentDate).add(Duration(days: day))));
//                  _appBarBloc
//                    ..add(ScheduleAppBarPageChange(
//                        DateTime.parse(currentDate).add(Duration(days: day))));
//                },
//                controller: _controller,
//                itemBuilder: (context, position) {
//                  return position != currentDay
//                      ? LoadWidget()
//                      : (state.scheduleElement.scheduleCell != null
//                          ? ScheduleBloc.getWidgetList(
//                              state.scheduleElement, _user)
//                          : EmptyDayWidget());
//                },
//              );
//            } else if (state is ScheduleDayChanged) {
////              currentDate = state.scheduleElement.date;
//              return PageView.builder(
//                onPageChanged: (value) {
////                  APIRequest.dio.lock();
//
//                  day = value < currentDay ? day - 1 : day + 1;
//                  currentDay = value;
//                  _appBarBloc
//                    ..add(ScheduleAppBarPageChange(
//                        DateTime.now().add(Duration(days: day))));
//
//                  _scheduleBloc.add(ScheduleDayChange(
//                      DateTime.now().add(Duration(days: day))));
//                },
//                controller: _controller,
//                itemBuilder: (context, position) {
//                  return position != currentDay
//                      ? LoadWidget()
//                      : (state.scheduleElement.scheduleCell != null
//                          ? ScheduleBloc.getWidgetList(
//                              state.scheduleElement, _user)
//                          : EmptyDayWidget());
//                },
//              );
//            } else {
//              return Center(
//                child: Text('Ошибка'),
//              );
//            }
//          },
//        ),
          ),
    );
  }
}
