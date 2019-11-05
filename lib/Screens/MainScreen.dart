import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timetable_app/APIRequest.dart';
import 'package:timetable_app/Models/User.dart';
import 'package:timetable_app/Screens/main.dart';
import 'package:timetable_app/Widgets/DisciplineRow.dart';
import 'package:timetable_app/Widgets/PerformanceRow.dart';


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
//  List<Widget> currentPage;
  AppBar appBar;

  APIRequest api = APIRequest();


  Widget currentWidget;

  MainScreenState(User user) : _user = user;

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
                accountEmail: Text('${_user.academicGroupName}'),
              ),
              color: Colors.yellow,
            ),
            ListTile(
              title: Text("Учебный план"),
              leading: Icon(Icons.info),
              onTap: () async {
                Navigator.pop(context);
                setState(() {
                  currentWidget = Center(child: CircularProgressIndicator(),);
                });
                var listDiscipline = await api.getCurriculumLoad(_user.curriculumId);
                setState(() {
                  currentWidget = PageView(
                    children: listDiscipline.map((term){
                      return ListView(children: term.values.map((discipline){
                        return DisciplineRow(discipline);
                      }).toList(),);
                    }).toList(),
                  );
                });


              },
            ),
            ListTile(
              title: Text("Расписание занятий"),
              leading: Icon(Icons.access_time),
              onTap: () {

              },
            ),
            ListTile(
              title: Text("Успеваемость"),
              leading: Icon(Icons.looks_5),
              onTap: () async {
                Navigator.pop(context);
                setState(() {
                  currentWidget = Center(child: CircularProgressIndicator(),);
                });

                var performanceList = await api.getEducationalPerformance(_user.id, _user.recordbookId);

                setState(() {
                  currentWidget = PageView(
                    children: performanceList.map((list){
                      return ListView(children: list.map((mark){
                        return PerformanceRow(mark);
                      }).toList(),);
                    }).toList(),
                  );
                });

              },
            ),
            Divider(),
            ListTile(
              title: Text("Выйти"),
              leading: Icon(Icons.exit_to_app),
              onTap: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                  return MyHomePage();
                }));
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

                  },
                ),
              )
            ],
          ),
        ),
        backgroundColor: Color.fromARGB(255, 255, 217, 122),
      ),
      body: currentWidget,
      backgroundColor: Colors.white,
    );
  }
}
