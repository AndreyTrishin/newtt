import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timetable_app/Models/User.dart';
import 'package:timetable_app/blocs/appBarBloc/AppBarBloc.dart';
import 'package:timetable_app/blocs/appBarBloc/AppBarEvent.dart';
import 'package:timetable_app/blocs/appBarBloc/AppBarState.dart';
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


  String pageName = 'Первый семестр';
  int pageNumber = 1;
  AppBarBloc _appBarBloc;
  String currentDate = '10.09';


  @override
  Widget build(BuildContext context) {
    _appBarBloc = AppBarBloc(_user);
    _scheduleBloc = ScheduleBloc(_user);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 255, 217, 122),
        title: Container(
          child: BlocBuilder(
              bloc: _appBarBloc,
              builder: (context, state) {
                if (state is AppBarUnitialized) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: 40,
                        child: FlatButton(
                          shape: CircleBorder(),
                          child: Icon(Icons.chevron_left),
                          onPressed: () {
                            _appBarBloc..add(AppBarPageChange(pageNumber - 1));
//                              _performanceBloc..add(PerformancePageChange(-1));
                            _controller.previousPage(
                                duration: Duration(milliseconds: 150),
                                curve: Curves.linear);
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Расписание занятий',
                              style: TextStyle(color: Colors.black, fontSize: 15),
                            ),
                            Text(currentDate
                              ,
                              style:
                                  TextStyle(fontSize: 13, color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                      FlatButton(
                        shape: CircleBorder(),
                        child: Icon(Icons.chevron_right),
                        onPressed: () {
                          _controller.nextPage(
                              duration: Duration(milliseconds: 150),
                              curve: Curves.linear);
                          _appBarBloc..add(AppBarPageChange(pageNumber + 1));
                        },
                      ),
                    ],
                  );
                } else if (state is AppBarPageChanged) {
                  pageNumber = state.newPage;
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Container(
                        width: 40,
                        child: FlatButton(
                          shape: CircleBorder(),
                          child: Icon(Icons.chevron_left),
                          onPressed: () {
                            _appBarBloc..add(AppBarPageChange(pageNumber));
//                              _performanceBloc..add(PerformancePageChange(-1));
                            _controller.previousPage(
                                duration: Duration(milliseconds: 150),
                                curve: Curves.linear);
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Расписание занятий',
                              style: TextStyle(color: Colors.black),
                            ),
                            Text(
                              pageName,
                              style:
                                  TextStyle(fontSize: 13, color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                      FlatButton(
                        shape: CircleBorder(),
                        child: Icon(Icons.chevron_right),
                        onPressed: () {
                          _appBarBloc..add(AppBarPageChange(pageNumber + 1));

                          _controller.nextPage(
                              duration: Duration(milliseconds: 150),
                              curve: Curves.linear);
                        },
                      ),
                    ],
                  );
                }
                return Text(
                  'Расписание занятий',
                  style: TextStyle(color: Colors.black),
                );
              }),
        ),
        leading: FlatButton(
          child: Icon(Icons.dehaze),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        ),
      ),
      body: Container(
//        margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
        child: BlocBuilder(
          bloc: _scheduleBloc..add(ScheduleLoad()),
          builder: (context, state) {
            print(state);
            if (state is ScheduleLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is ScheduleLoaded) {
              return PageView.builder(
                dragStartBehavior: DragStartBehavior.start,
                onPageChanged: (value) {
                  day = value < currentDay ? -1 : 1;
                  currentDay = value;
                  _scheduleBloc
                    ..add(ScheduleDayChange(
                        DateTime.parse(state.scheduleElement.date)
                            .add(Duration(days: day))));
                  _appBarBloc..add(AppBarPageChange(value - 5000));
                },
                controller: _controller,
                itemBuilder: (context, position) {
                  return position != currentDay
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : (state.scheduleElement.scheduleCell != null
                          ? ScheduleBloc.getWidgetList(state.scheduleElement)
                          : Center(
                              child: Text('Свободный день'),
                            ));
                },
              );
            } else if (state is ScheduleDayChanged) {
              currentDate=state.scheduleElement.date;
              return PageView.builder(
                dragStartBehavior: DragStartBehavior.start,
                onPageChanged: (value) {
                  day = value < currentDay ? -1 : 1;
                  currentDay = value;
                  _scheduleBloc
                    ..add(ScheduleDayChange(
                        DateTime.parse(state.scheduleElement.date)
                            .add(Duration(days: day))));
                },
                controller: _controller,
                itemBuilder: (context, position) {
                  return position != currentDay
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : (state.scheduleElement.scheduleCell != null
                          ? ScheduleBloc.getWidgetList(state.scheduleElement)
                          : Center(
                              child: Text('Свободный день'),
                            ));
                },
              );
            } else {
              return Center(
                child: Text('Ошибка'),
              );
            }
          },
        ),
      ),
    );
  }
}
