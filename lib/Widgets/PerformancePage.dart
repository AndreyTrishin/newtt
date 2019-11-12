import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timetable_app/Models/MarkRecord.dart';
import 'package:timetable_app/Models/Universe.dart';
import 'package:timetable_app/Models/User.dart';
import 'package:timetable_app/Widgets/PerformanceRow.dart';
import 'package:timetable_app/blocs/appBarBloc/AppBarBloc.dart';
import 'package:timetable_app/blocs/appBarBloc/AppBarEvent.dart';
import 'package:timetable_app/blocs/appBarBloc/AppBarState.dart';
import 'package:timetable_app/blocs/performanceBloc/performanceBloc.dart';
import 'package:timetable_app/blocs/performanceBloc/performanceEvent.dart';
import 'package:timetable_app/blocs/performanceBloc/performanceState.dart';

class PerformancePage extends StatelessWidget {
  PageController _controller = PageController();
  String pageName = 'Первый семестр';
  int pageNumber = 1;

  Map<int, String> mapTerms = {
    1: 'Первый семестр',
    2: 'Второй семестр',
    3: 'Третий семестр',
    4: 'Четвертый семестр',
    5: 'Пятый семестр',
    7: 'Седьмой семестр',
    6: 'Шестой семестр',
    8: 'Восьмой семестр',
    9: 'Девятый семестр',
    10: 'Десятый семестр',
    11: 'Одиннадцатый семестр',
  }; //список семестров

  User _user;

  PerformancePage(this._user);

  PerformanceBloc _performanceBloc;

  AppBarBloc _appBarBloc;
  static List<List<MarkRecord>> markList = [];

  @override
  Widget build(BuildContext context) {
    _performanceBloc = PerformanceBloc(_user);
    _appBarBloc = AppBarBloc(_user, markList);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 255, 217, 122),
        title: Container(
            child: Row(

              children: <Widget>[
                Container(
                  width: 40,
                  height: 40,
                  child: FlatButton(
                    shape: CircleBorder(),
                    child: Icon(Icons.chevron_left),
                    onPressed: () {
                      _appBarBloc..add(AppBarPageChange(pageNumber - 1));
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
                        'Успеваемость',
                        style: TextStyle(color: Colors.black),
                      ),
                      BlocBuilder(
                        bloc: _appBarBloc,
                        builder: (context, state) {
                          if (state is AppBarUnitialized) {
                            return Text(
                              pageName,
                              style: TextStyle(fontSize: 13, color: Colors.black),
                            );
                          } else if (state is AppBarPageChanged) {
                            pageNumber = state.newPage;
                            return Text(
                              mapTerms[state.newPage],
                              style: TextStyle(fontSize: 13, color: Colors.black),
                            );
                          } else {
                            return Text('Ошибка');
                          }
                        },
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      width: 40,
                      child: FlatButton(
                        shape: CircleBorder(),
                        child: Icon(Icons.chevron_right),
                        onPressed: () {
                          _controller.nextPage(
                              duration: Duration(milliseconds: 150),
                              curve: Curves.linear);
                          _appBarBloc..add(AppBarPageChange(pageNumber + 1));
                        },
                      ),
                    ),
                  ),
                ),
              ],
            )),
        leading: FlatButton(
          child: Icon(Icons.dehaze),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        ),
      ),
      body: BlocBuilder(
        bloc: _performanceBloc..add(PerformanceLoad()),
        // ignore: missing_return
        builder: (context, state) {
          if (state is PerformanceLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is PerformanceLoaded) {
            markList = state.performanceList;
            return PageView(
              onPageChanged: (value) {
                _appBarBloc..add(AppBarPageChange(value+1));
              },
              controller: _controller,
              children: markList.map<Widget>((term) {
                return ListView(
                  children: term.map<Widget>((mark) {
                    return PerformanceRow(mark);
                  }).toList(),
                );
              }).toList(),
            );
          }else if (state is PerformanceNotLoaded) {
            return Center(
              child: Text('Ошибка загрузки'),
            );
          } else {
            return Center(
              child: Text('Ошибка'),
            );
          }

        },
      ),
    );
  }
}
//
//
//return Row(
//mainAxisAlignment: MainAxisAlignment.spaceAround,
//children: <Widget>[
////                  Container(
////                    width: 40,
////                    child: FlatButton(
////                      shape: CircleBorder(),
////                      child: Icon(Icons.chevron_left),
////                      onPressed: (){
////                        _controller.previousPage(duration: Duration(milliseconds: 150), curve: Curves.linear);
////                      },
////                    ),
////                  ),
//Padding(
//padding: const EdgeInsets.all(8.0),
//child: Column(
//crossAxisAlignment: CrossAxisAlignment.start,
//children: <Widget>[
//Text('Успеваемость', style: TextStyle(color: Colors.black),),
//Text(pageName, style: TextStyle(fontSize: 13, color: Colors.black),),
//],
//),
//),
////                  FlatButton(
////                    shape: CircleBorder(),
////                    child: Icon(Icons.chevron_right),
////                    onPressed: (){
////                      _controller.nextPage(duration: Duration(milliseconds: 150), curve: Curves.linear);
////                    },
////                  ),
//],
//);
