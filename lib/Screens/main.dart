import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:timetable_app/APIRequest.dart';
import 'package:timetable_app/Models/User.dart';
import 'package:timetable_app/Screens/TeacerScreen.dart';
import 'package:timetable_app/SharedPref.dart';

import 'MainScreen.dart';
import 'UnivercityList.dart';

main() async {
  User user;
  try {
    user = User.fromJson(await SharedPref().read('user'));
  } catch (_) {
    user = null;
  }

  runApp(MaterialApp(
    title: 'Университет',
    home: MyHomePage(),
//    home: user == null ? MyHomePage() : MainScreen(user),
    color: Colors.amberAccent,
  ));
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String dropdownValue = "МГПИ";

  TextEditingController controllerName =
      TextEditingController(text: 'Иван Иванов');
  TextEditingController controllerPassword =
      TextEditingController(text: 'demo');
  TextEditingController controllerUniverse = TextEditingController();
  InputBorder inputBorder;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
      body: Container(
        color: Color.fromARGB(255, 255, 248, 226),
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('res/background_login_page.png'),
                  fit: BoxFit.cover)),
          margin: EdgeInsets.fromLTRB(0, 100, 0, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                padding: EdgeInsets.all(10.0),
                child: TextFormField(
                  readOnly: true,
                  controller: controllerUniverse,
                  decoration: InputDecoration(
//                    hoverColor: Colors.black,
                      suffixIcon: Icon(Icons.arrow_drop_down),
                      labelText: 'Название ВУЗа'),
                  onTap: () async {
                    controllerUniverse.text = await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UnivercityList()));
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                padding: EdgeInsets.all(10.0),
                child: TextField(
                    cursorColor: Colors.red,
                    controller: controllerName,
                    decoration: InputDecoration(
                        focusedBorder: inputBorder,
                        labelText: 'Ваша фамилия, имя и отчество')),
              ),
              Container(
                margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                padding: EdgeInsets.all(10.0),
                child: TextFormField(
                  controller: controllerPassword,
                  obscureText: true,
                  decoration: InputDecoration(labelText: 'Пароль'),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30),
                alignment: Alignment.centerRight,
                child: RaisedButton(
                  color: Colors.red,
                  onPressed: () async {
                    User user = await APIRequest.authorisation(
                        controllerName.text, controllerPassword.text);
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('Выберите роль пользователя'),
                            actions: <Widget>[
                              FlatButton(
                                child: Text('Обучающийся'),
                                onPressed: () {
                                  Navigator.pushReplacement(context,
                                      MaterialPageRoute(builder: (context) {
//                      return test;
                                        return MainScreen(user);
                                      }));
                                },
                              ),
                              FlatButton(
                                child: Text('Преподаватель'),
                                onPressed: (){
                                  Navigator.pushReplacement(context,
                                      MaterialPageRoute(builder: (context) {
                                        return TeacherScreen();
                                      }));
                                },
                              ),
                            ],
                          );
                        });
//                    CurriculumLoad test = CurriculumLoad();
//                    SharedPref().save('user', user);
                  },
                  child: Text(
                    'ВОЙТИ',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
