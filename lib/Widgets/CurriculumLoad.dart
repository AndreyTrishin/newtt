import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timetable_app/Models/Discipline.dart';
import 'package:timetable_app/Models/Universe.dart';
import 'package:timetable_app/Models/User.dart';
import 'package:timetable_app/Widgets/DisciplineRow.dart';
import 'package:timetable_app/blocs/appBarBloc/AppBarBloc.dart';
import 'package:timetable_app/blocs/appBarBloc/AppBarEvent.dart';
import 'package:timetable_app/blocs/appBarBloc/AppBarState.dart';
import 'package:timetable_app/blocs/curriculumLoadBloc/curriculumLoadBloc.dart';
import 'package:timetable_app/blocs/curriculumLoadBloc/curriculumLoadEvent.dart';
import 'package:timetable_app/blocs/curriculumLoadBloc/curriculumLoadState.dart';

class CurriculumLoad extends StatelessWidget {
  User _user;

  CurriculumLoad(this._user);

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

  AppBarBloc _appBarBloc;

  static List<List<Discipline>> disciplines = [];

  @override
  Widget build(BuildContext context) {
    _appBarBloc = AppBarBloc(_user, disciplines);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 255, 217, 122),
        title: Container(
            child: Row(
//                    mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Container(
              width: 40,
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
                    'Учебный план',
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
      body: BlocProvider(
        builder: (context) =>
            CurriculumLoadBloc(_user)..add(LoadCurriculumLoad()),
        child: BlocBuilder<CurriculumLoadBloc, CurriculumLoadState>(
          bloc: CurriculumLoadBloc(_user)..add(LoadCurriculumLoad()),
          builder: (context, state) {
            if (state is CurriculumLoadLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is CurriculumLoadLoaded) {
              disciplines = state.disciplines;
              return PageView(
                onPageChanged: (value) {
                  _appBarBloc..add(AppBarPageChange(value + 1));
                },
                controller: _controller,
                children: disciplines.map<Widget>((term) {
                  return ListView(
                    children: term.map<Widget>((discipline) {
                      return DisciplineRow(discipline);
                    }).toList(),
                  );
                }).toList(),
              );
            } else if (state is CurriculumLoadNotLoaded) {
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
      ),
    );
  }
}
