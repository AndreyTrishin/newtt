import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:just_debounce_it/just_debounce_it.dart';
import 'package:timetable_app/Models/User.dart';
import 'package:timetable_app/Widgets/EmptyDayWidget.dart';
import 'package:timetable_app/Widgets/EmptyTTRow.dart';
import 'package:timetable_app/Widgets/LoadWidget.dart';
import 'package:timetable_app/Widgets/Timetable.dart';
import 'package:timetable_app/blocs/scheduleAppBarBloc/ScheduleAppBarBloc.dart';
import 'package:timetable_app/blocs/scheduleAppBarBloc/ScheduleAppBarState.dart';
import 'package:timetable_app/blocs/scheduleAppBarBloc/scheduleAppBarEvent.dart';
import 'package:timetable_app/blocs/scheduleBloc/scheduleBloc.dart';
import 'package:timetable_app/blocs/scheduleBloc/scheduleEvent.dart';
import 'package:timetable_app/blocs/scheduleBloc/scheduleState.dart';

class SchedulePage extends StatefulWidget {
  User _user;

  SchedulePage(this._user);

  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  PageController _controller = PageController(initialPage: 5000);

  ScheduleBloc _scheduleBloc;

  int currentDay = 5000;

  int day = 0;

  int pageNumber = 1;

  ScheduleAppBarBloc _appBarBloc;

  DateTime currentDate = DateTime.now();

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
  void initState() {
    super.initState();

    target = () {
      _scheduleBloc
          .add(ScheduleDayChange(DateTime.now().add(Duration(days: day))));
    };
    _appBarBloc = ScheduleAppBarBloc();
    _scheduleBloc = ScheduleBloc(widget._user);
  }

  Function target;

  @override
  Widget build(BuildContext context) {
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
                            builder: (BuildContext context, Widget child) {
                              return Theme(
                                data: ThemeData(
                                  primaryColor:
                                      Color.fromARGB(255, 255, 217, 122),
                                  accentColor:
                                      Color.fromARGB(255, 255, 217, 122),
                                ),
                                child: child,
                              );
                            },
                            context: context,
                            initialDate: currentDate,
                            firstDate: DateTime(2015),
                            lastDate: DateTime(2021));
                        if (date != null) {
                          currentDate = date;
                          currentDay = 5000;
                          _appBarBloc..add(ScheduleAppBarPageChange(date));
                          Debounce.seconds(1, () {
                            _controller.jumpToPage(currentDay);

                            _scheduleBloc.add(ScheduleDayChange(date));
                          });
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
      body: Container(
          margin: EdgeInsets.fromLTRB(
              0, ScreenUtil.getInstance().setHeight(30), 0, 0),
          child: BlocBuilder(
            bloc: _scheduleBloc..add(ScheduleLoad(currentDate)),
            builder: (context, state) {
              if (state is ScheduleLoading) {
                return LoadWidget();
              } else {
                return PageView.builder(
                  onPageChanged: (value) {
                    Debounce.clear(target);
                    day = value < currentDay ? -1 : 1;
                    currentDay = value;
                    currentDate = currentDate.add(Duration(days: day));
                    _appBarBloc..add(ScheduleAppBarPageChange(currentDate));
                    Debounce.seconds(1, target);
                  },
                  itemBuilder: (context, index) {
                    return BlocBuilder(
                      bloc: _scheduleBloc,
                      builder: (context, state) {
                        if (state is ScheduleLoaded && index == 5000) {
                          int i = 0;
                          return state.scheduleElement.scheduleCell != null
                              ? ListView(
                                  children: state.scheduleElement.scheduleCell
                                      .map((cell) {
                                    i++;
                                    if (i < 6) {
                                      return cell.lesson != null
                                          ? Timetable(cell, i)
                                          : EmptyTTRow(cell, i);
                                    } else {
                                      return Container();
                                    }
                                  }).toList(),
                                )
                              : EmptyDayWidget();
                        } else if (state is ScheduleDayChanged &&
                            index == currentDay) {
                          int i = 0;
                          return state.scheduleElement.scheduleCell != null
                              ? ListView(
                                  children: state.scheduleElement.scheduleCell
                                      .map((cell) {
                                    i++;
                                    if (i < 6) {
                                      return cell.lesson != null
                                          ? Timetable(cell, i)
                                          : EmptyTTRow(cell, i);
                                    } else {
                                      return Container();
                                    }
                                  }).toList(),
                                )
                              : EmptyDayWidget();
                        } else {
                          return LoadWidget();
                        }
                      },
                    );
                  },
                  controller: _controller,
                );
              }
            },
          )),
    );
  }
}
