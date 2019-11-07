import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timetable_app/Models/User.dart';
import 'package:timetable_app/SharedPref.dart';
import 'package:timetable_app/Widgets/CurriculumLoad.dart';
import 'package:timetable_app/Widgets/PerformancePage.dart';
import 'package:timetable_app/Widgets/SchedulePage.dart';

import 'main.dart';

class MainScreen extends StatefulWidget {
  User _user;

  MainScreen(User user) : _user = user;

  @override
  createState() => MainScreenState(_user);
}

class MainScreenState extends State<MainScreen> {
  SharedPref sp = SharedPref();
  User _user;
//  PageController _pageController;
  var currentWindowName;

  AppBar appBar;

  Widget currentWidget;

  MainScreenState(User user) : _user = user;

  int number = 0;
  String numberName = 'Первый семестр';


  _downloadWindow() async {
    currentWindowName = await sp.loadWindow();

    switch (currentWindowName) {
      case 'Учебный план':
        setState(() {
          currentWindowName = 'Учебный план';
          currentWidget = CurriculumLoad(_user);
        });
        break;
      case 'Успеваемость':
        setState(() {
          currentWindowName = 'Успеваемость';
          currentWidget = PerformancePage(_user);
        });
        break;
    }
  }

  @override
  initState() {
    _downloadWindow();
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
                accountEmail: Text('${_user.specialtyName}'),
              ),
              color: Colors.yellow,
            ),
            ListTile(
              title: Text("Учебный план"),
              leading: Icon(Icons.info),
              onTap: () async {
                sp.setCurrentWindow('Учебный план');
                Navigator.pop(context);
                setState(() {
//                  currentWindowName = 'Учебный план';
                  currentWidget = CurriculumLoad(_user);
                });
              },
            ),
            ListTile(
              title: Text("Расписание занятий"),
              leading: Icon(Icons.access_time),
              onTap: () async {
                Navigator.pop(context);
                setState(() {
//                  currentWindowName = 'Расписание занятий';
                  currentWidget = SchedulePage(_user);
                });

              },
            ),
            ListTile(
              title: Text("Успеваемость"),
              leading: Icon(Icons.looks_5),
              onTap: () async {
                sp.setCurrentWindow('Успеваемость');
                Navigator.pop(context);
                setState(() {
                  currentWindowName = 'Успеваемость';
                  currentWidget = PerformancePage(_user);
                });
              },
            ),
            Divider(),
            ListTile(
              title: Text("Выйти"),
              leading: Icon(Icons.exit_to_app),
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) {
                  return MyHomePage();
                }));
              },
            ),
          ],
        ),
      ),
//      appBar: AppBar(
//        iconTheme: IconThemeData(color: Colors.black),
//        textTheme: TextTheme(
//          title: TextStyle(color: Colors.black, fontSize: 18),
////          subtitle: TextStyle(color: Colors.black),
//        ),
//        title: Container(
//          child: Row(
//            children: <Widget>[
//              Container(
//                margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
//                child: GestureDetector(
//                  child: Container(
//                    child: Icon(Icons.chevron_left),
//                  ),
//                  onTap: () {
//                    if (number > 1) {
//                      setState(() {
//                        number--;
//                        numberName = map[number];
//                      });
//                      _pageController.previousPage(
//                        duration: Duration(milliseconds: 300),
//                        curve: Curves.linear,
//                      );
//                    }
//                  },
//                ),
//              ),
//              Column(
//                crossAxisAlignment: CrossAxisAlignment.start,
//                children: <Widget>[
//                  Container(
//                    child: Text(''),
//                    margin: EdgeInsets.fromLTRB(0, 12, 0, 0),
//                  ),
//                  Container(
//                      child: Text(
//                    '$numberName',
//                    style: TextStyle(fontSize: 12),
//                  )),
//                ],
//              ),
//              Container(
//                child: FlatButton(
//                  child: Icon(Icons.chevron_right),
//                  onPressed: () {
//                    setState(() {
//                      number++;
//                      numberName = map[number];
//                    });
//                    _pageController.nextPage(
//                      duration: Duration(milliseconds: 300),
//                      curve: Curves.linear,
//                    );
//                  },
//                ),
//              )
//            ],
//          ),
//        ),
//        backgroundColor: Color.fromARGB(255, 255, 217, 122),
//      ),
      body: currentWidget,
      backgroundColor: Colors.white,
    );
  }
}
