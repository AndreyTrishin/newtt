import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Models/Discipline.dart';
import 'DisciplineRow.dart';
import 'Models/Group.dart';
import 'Models/Performance.dart';
import 'Models/User.dart';
import 'PerformanceRow.dart';
import 'Timetable.dart';

class MainScreen extends StatefulWidget {
  User _user;

  MainScreen(User user) : _user = user;

  @override
  createState() => MainScreenState(_user);
}

class MainScreenState extends State<MainScreen> {
  User _user;
  PageController _pageController;
  String currentGroup;
  List<Widget> currentPage;
  AppBar appBar;

  int number = 0;
  String numberName = 'Первый семестр';
  Map<int, String> map = {
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

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    currentGroup = _user.group;
    currentPage = getDisciplinelist(currentGroup);
  }

  List<Group> groupList = [
    Group('3', [
      Semester(1, [
        Discipline('Информатика', 'ЭКЗАМЕН', true, 30, 20),
        Discipline('Биология', 'ЗАЧЁТ', false, 30, 40),
        Discipline('Физика', 'ЭКЗАМЕН', false, 25, 20),
        Discipline('Философия', 'ЗАЧЁТ', true, 26, 33),
        Discipline('Русский язык', 'ЗАЧЁТ', true, 26, 33),
      ]),
      Semester(2, [
        Discipline('Аналитическая химия', 'ЭКЗАМЕН', true, 30, 20),
        Discipline('Высшая математика', 'ЗАЧЁТ', false, 30, 40),
        Discipline('Химия', 'ЭКЗАМЕН', false, 25, 20),
        Discipline('Ботаника', 'ЗАЧЁТ', true, 26, 33),
        Discipline('Геология', 'ЗАЧЁТ', true, 26, 33),
      ]),
      Semester(3, [
        Discipline('Иностранный язык', 'ЗАЧЁТ', true, 30, 20),
        Discipline('Физическая культура', 'ЗАЧЁТ', false, 30, 40),
        Discipline('Информатика', 'ЭКЗАМЕН', false, 25, 20),
        Discipline('Картография', 'ЭКЗАМЕН', true, 26, 33),
        Discipline('Русский язык', 'ЗАЧЁТ', true, 26, 33),
      ]),
      Semester(4, [
        Discipline('Иностранный язык', 'ЗАЧЁТ', true, 30, 20),
        Discipline('Физическая культура', 'ЗАЧЁТ', false, 30, 40),
        Discipline('Информатика', 'ЭКЗАМЕН', false, 25, 20),
        Discipline('Картография', 'ЭКЗАМЕН', true, 26, 33),
        Discipline('Русский язык', 'ЗАЧЁТ', true, 26, 33),
      ]),
    ]),
  ]; //списки групп

  List<Performance> performanceList1 = [
    Performance('Информатика', 'Зачёт', DateTime(2010, 10, 10)),
    Performance('Биология', '3', DateTime(2010, 10, 10)),
    Performance('Физика', '4', DateTime(2010, 10, 10)),
    Performance('Философия', '5', DateTime(2010, 10, 10)),
    Performance('Русский язык', 'Зачёт', DateTime(2010, 10, 10)),
    Performance('Русский язык', 'Незачёт', DateTime(2010, 10, 10)),
  ];
  List<Performance> performanceList2 = [
    Performance('Аналитическая химия', 'Зачёт', DateTime(2010, 10, 10)),
    Performance('Высшая математика', '5', DateTime(2010, 10, 10)),
    Performance('Химия', '4', DateTime(2010, 10, 10)),
    Performance('Философия', '2', DateTime(2010, 10, 10)),
    Performance('Физическая культура', 'Зачёт', DateTime(2010, 10, 10)),
  ]; //списки успеваемости

  MainScreenState(User user) : _user = user;

  int getCurrentGroup() {
    for (int i = 0; i < groupList.length; i++) {
      if (groupList[i].name == _user.group) {
        return i;
      }
    }
  }

  List<Widget> getDisciplinelist(String groupName) {
    List<Widget> list = [];
    for (Group group in groupList) {
      if (group.name == groupName) {
        for (Semester d in group.listSemester) {
          List<Widget> n = [];
          for (Discipline s in d.disciplineList) {
            n.add(DisciplineRow(s));
            n.add(Divider());
          }
          list.add(ListView(
            children: n,
          ));
        }
      }
    }
    return list;
  }

  List<ListView> getPerformanceList(List<Performance> inputList) {
    List<Widget> listTile = [];
    for (Performance p in inputList) {
      listTile.add(PerformanceRow(p));
      listTile.add(Divider(
        height: 0,
      ));
    }
    List<ListView> list = [ListView(children: listTile)];
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            Container(
              child: UserAccountsDrawerHeader(
                accountName: Text('${_user.name}'),
                accountEmail: Text('${_user.email}'),
              ),
              color: Colors.yellow,
            ),
            ListTile(
              title: Text("Учебный план"),
              leading: Icon(Icons.info),
              onTap: () {
                setState(() {
                  currentPage = getDisciplinelist(currentGroup);
                });
              },
            ),
            ListTile(
              title: Text("Расписание занятий"),
              leading: Icon(Icons.access_time),
              onTap: () {
                setState(() {
                  List<Timetable> list = [
                    Timetable(),
                    Timetable(),
                    Timetable(),
                    Timetable(),
                    Timetable(),
                  ];
                  currentPage = list;
                });
              },
            ),
            ListTile(
              title: Text("Успеваемость"),
              leading: Icon(Icons.looks_5),
              onTap: () {
                setState(() {
                  List<ListView> list1 = getPerformanceList(performanceList1);
                  List<ListView> list2 = getPerformanceList(performanceList2);
                  list1.add(list2[0]);
                  currentPage = list1;
                });
              },
            ),
            Divider(),
            ListTile(
              title: Text("Выйти"),
              leading: Icon(Icons.exit_to_app),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        textTheme: TextTheme(
          title: TextStyle(color: Colors.black, fontSize: 18),
//          subtitle: TextStyle(color: Colors.black),
        ),
        title: Container(
          child: Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                child: GestureDetector(
                  child: Container(
                    child: Icon(Icons.chevron_left),
                  ),
                  onTap: () {
                    if (number > 1) {
                      setState(() {
                        number--;
                        numberName = map[number];
                        _pageController.previousPage(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.linear,
                        );
                      });
                    }
                  },
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Text('Учебный план'),
                    margin: EdgeInsets.fromLTRB(0, 12, 0, 0),
                  ),
                  Container(
                      child: Text(
                    '$numberName',
                    style: TextStyle(fontSize: 12),
                  )),
                ],
              ),
              Container(
                child: FlatButton(
                  child: Icon(Icons.chevron_right),
                  onPressed: () {
                    setState(() {
                      //TODO: не настроено перемещение до конца, нет определения группы пользователя
                      if (number != groupList[0].listSemester.length) {
                        number++;
                        numberName = map[number];
                        _pageController.nextPage(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.linear,
                        );
                      }
                    });
                  },
                ),
              )
            ],
          ),
        ),
        backgroundColor: Color.fromARGB(255, 255, 217, 122),
      ),
      body: PageView(
        controller: _pageController,
        children: currentPage,
        onPageChanged: (value) {
          setState(() {
            number = value + 1;
            numberName = map[number];
          });
        },
      ),
      backgroundColor: Colors.white,
    );
  }
}
