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

import '../LoadWidget.dart';

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
    _appBarBloc = AppBarBloc();
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
                      _controller.previousPage(
                          duration: Duration(milliseconds: 150),
                          curve: Curves.linear);
                      if (pageNumber != 1) {
                        pageNumber--;
                        _appBarBloc..add(AppBarPageChange(pageNumber));
                      }
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
                              style: TextStyle(
                                  fontSize: 13, color: Colors.black),
                            );
                          } else if (state is AppBarPageChanged) {
                            pageNumber = state.newPage;
                            return Text(
                              mapTerms[state.newPage],
                              style: TextStyle(
                                  fontSize: 13, color: Colors.black),
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
                          if (pageNumber != markList.length) {
                            pageNumber++;
                            _appBarBloc..add(AppBarPageChange(pageNumber));
                          }
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
              child: LoadWidget(),
            );
          }
          if (state is PerformanceLoaded) {
            markList = state.performanceList;
            return ScrollConfiguration(
              behavior: ScrollBehavior(),
              child: GlowingOverscrollIndicator(
                axisDirection: AxisDirection.right,
                color: Colors.yellow,
                child: PageView(
                  onPageChanged: (value) {
                    _appBarBloc..add(AppBarPageChange(value + 1));
                  },
                  controller: _controller,
                  children: markList.map<Widget>((term) {
                    return ScrollConfiguration(
                      behavior: ScrollBehavior(),
                      child: GlowingOverscrollIndicator(
                        color: Colors.yellow,
                        axisDirection: AxisDirection.down,
                        child: ListView.separated(itemBuilder: (context, position) {
                          return PerformanceRow(term[position]);
                        },
                            separatorBuilder: (context, position) {
                          return Divider(height: 0,);
                            },
                            itemCount: term.length),
                      ),
                    );
                  }).toList(),
                ),
              ),
            );
          } else if (state is PerformanceNotLoaded) {
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