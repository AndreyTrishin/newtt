
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:timetable_app/Timetable.dart';

import 'DisciplineInfo.dart';
import 'MainScreen.dart';
import 'Models/User.dart';


void main() {
  runApp(MaterialApp(
//    home: MyHomePage(),
    initialRoute: '/',
    routes: {
      '/': (BuildContext context) => MyHomePage(),
      '/info': (BuildContext context) => DisciplineInfo(null),
      '/main': (BuildContext context) => MainScreen(null),
      '/tt': (BuildContext context) => Timetable(),
    },
    color: Colors.amberAccent,
  ));
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title, User user}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String dropdownValue = "МГПИ";
  String name, password;

  List<User> userList = [
    User('Ivanov Ivan', 'ivanov_i@mail.ru', '1234', '1'),
    User('Petrov', 'petrov_p@mail.ru', '1234', '2'),
    User('Sergeev', 'sergeev_s@mail.ru', '1234', '3'),
    User('1', '1@mail.ru', '1', '3'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(10.0),
            child: DropdownButton<String>(
              value: dropdownValue,
              onChanged: (String newValue) {
                setState(() {
                  dropdownValue = newValue;
                });
              },
              items: <String>['МГПИ', 'НГАСУ', 'ФГБОУ']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 20.0, right: 20.0),
            padding: EdgeInsets.all(10.0),
            child: TextFormField(
                onChanged: (value) {
                  name = value;
                },
                decoration:
                    InputDecoration(labelText: 'Ваша фамилия, имя и отчество')),
          ),
          Container(
            margin: const EdgeInsets.only(left: 20.0, right: 20.0),
            padding: EdgeInsets.all(10.0),
            child: TextFormField(
              obscureText: true,
              decoration: InputDecoration(labelText: 'Пароль'),
              onChanged: (value) {
                password = value;
              },
            ),
          ),
          Container(
            child: Wrap(
              children: <Widget>[
                RaisedButton(
                  onPressed: () {
                    for (User user in userList) {
                      if (user.name == name) {
                        if (user.passwrod == password) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MainScreen(user)));
                        } else {}
                      }
                    }
                  },
                  child: Text('Войти'),
                ),
              ],
              crossAxisAlignment: WrapCrossAlignment.end,
            ),
          ),
        ],
      ),
    );
  }
}



