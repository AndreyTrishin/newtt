import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:just_debounce_it/just_debounce_it.dart';
import 'package:timetable_app/Models/Universe.dart';
import 'package:timetable_app/Models/User.dart';
import 'package:timetable_app/Widgets/EmptyDayWidget.dart';
import 'package:timetable_app/Widgets/EmptyTTRow.dart';
import 'package:timetable_app/Widgets/LoadWidget.dart';
import 'package:timetable_app/Widgets/TeacherTimetable.dart';
import 'package:timetable_app/blocs/scheduleAppBarBloc/ScheduleAppBarBloc.dart';
import 'package:timetable_app/blocs/scheduleAppBarBloc/ScheduleAppBarState.dart';
import 'package:timetable_app/blocs/scheduleAppBarBloc/scheduleAppBarEvent.dart';
import 'package:timetable_app/blocs/scheduleBloc/scheduleBloc.dart';
import 'package:timetable_app/blocs/scheduleBloc/scheduleEvent.dart';
import 'package:timetable_app/blocs/scheduleBloc/scheduleState.dart';

import '../APIRequest.dart';
import '../main.dart';

class TeacherScreen extends StatelessWidget {
  final User _user;

  Function() target;

  TeacherScreen(this._user);

  ScheduleAppBarBloc _appBarBloc;
  ScheduleBloc _scheduleBloc;

  PageController _controller = PageController(initialPage: 5000);

  int currentDay = 5000;
  int day = 0;

  int pageNumber = 1;
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
    target = () {
      _scheduleBloc
          .add(ScheduleDayChange(DateTime.now().add(Duration(days: day))));
    };

    _appBarBloc = ScheduleAppBarBloc();
    _scheduleBloc = ScheduleBloc(_user);
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('res/background_drawer_header.png'),
                      fit: BoxFit.cover)),
              accountName: Text('${_user.name}'),
              accountEmail: Text('Преподаватель'),
            ),
            ListTile(
              onTap: (){
                Navigator.pop(context);
              },
              leading: Icon(Icons.access_time),
              title: Text('Расписание занятий'),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Container(
//                    decoration: BoxDecoration(border: Border.fromBorderSide(BorderSide(width: 1))),
                  child: ListTile(
                    title: Text("Выйти"),
                    leading: Icon(Icons.exit_to_app),
                    onTap: () {
                      APIRequest.idServer = null;
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) {
                        return MyHomePage(null);
                      }));
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Color.fromARGB(255, 255, 217, 122),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(0),
              width: 60,
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
              width: MediaQuery.of(context).size.width / 2 - 40,
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
                    currentDate =
                        DateFormat('yyyy-MM-dd').format(state.newDate);

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
              width: 60,
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
                  width: 40,
                  child: FlatButton(
                    shape: CircleBorder(),
                    child: Icon(Icons.event),
                    onPressed: () async {
                      DateTime date = await showDatePicker(
                          context: context,
                          initialDate: DateTime.parse(currentDate),
                          firstDate: DateTime(2015),
                          lastDate: DateTime(2021));
                      currentDate = date.toString().substring(0, 10);
                      _scheduleBloc..add(ScheduleDayChange(date));
                      _appBarBloc..add(ScheduleAppBarPageChange(date));
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
            bloc: _scheduleBloc..add(ScheduleLoad(DateTime.parse(currentDate))),
            builder: (context, state) {
              if (state is ScheduleLoading) {
                return LoadWidget();
              } else {
                return PageView.builder(
                  onPageChanged: (value) {
                    Debounce.clear(target);
                    day = value < currentDay ? day - 1 : day + 1;
                    currentDay = value;
                    _appBarBloc.add(ScheduleAppBarPageChange(
                        DateTime.now().add(Duration(days: day))));
                    Debounce.seconds(1, target);
                  },
                  itemBuilder: (context, index) {
                    print(state);
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
                              if(i<6){

                                return cell.lesson != null
                                    ? TeacherTimetable(cell, i)
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
                              if(i<6){
                                return cell.lesson != null
                                    ? TeacherTimetable(cell, i)
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
