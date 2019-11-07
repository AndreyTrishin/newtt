import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timetable_app/Models/User.dart';
import 'package:timetable_app/blocs/scheduleBloc/scheduleBloc.dart';
import 'package:timetable_app/blocs/scheduleBloc/scheduleEvent.dart';
import 'package:timetable_app/blocs/scheduleBloc/scheduleState.dart';

class SchedulePage extends StatelessWidget {
  User _user;

  SchedulePage(this._user);

  ScheduleBloc _scheduleBloc;

  @override
  Widget build(BuildContext context) {
    _scheduleBloc = ScheduleBloc(_user);
    return Scaffold(
      appBar: AppBar(
        leading: FlatButton(
          child: Icon(Icons.dehaze),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
        title: Text(
          'Расписание занятий',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Color.fromARGB(255, 255, 217, 122),
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
              int i = 0;
              return PageView(
                controller: PageController(initialPage: 1),
                children: <Widget>[
                  Center(
                    child: CircularProgressIndicator(),
                  ),
                  _scheduleBloc.getWidgetList(state.scheduleElement),
                  Center(
                    child: CircularProgressIndicator(),
                  ),
                ],
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
