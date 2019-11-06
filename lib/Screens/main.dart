import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timetable_app/APIRequest.dart';
import 'package:timetable_app/Models/User.dart';
import 'package:timetable_app/Screens/Test/TestBlocCurriculumLoad.dart';
import 'package:timetable_app/SharedPref.dart';
import 'package:timetable_app/blocs/curriculumLoadBloc/curriculumLoadBloc.dart';
import 'package:timetable_app/blocs/curriculumLoadBloc/curriculumLoadEvent.dart';

main() async {
//  User user;
//
//  try{
//    user = User.fromJson(await SharedPref().read('user'));
//  } catch(_){
//    user = null;
//  }

  runApp(App());
//      MaterialApp(
//    home: MyHomePage(),
////    home: user == null ? MyHomePage() : MainScreen(user),
//    color: Colors.amberAccent,
//  ));
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Infinite Scroll',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Учебный план'),
        ),
//        body: TestBlocCurriculumLoad().add(LoadCurriculumLoad()),
        body: BlocProvider(
          builder: (context) => CurriculumLoadBloc()..add(LoadCurriculumLoad()),
          child: CurriculumLoad(),
        ),
      ),
    );
  }
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
                controller: controllerName,
                decoration:
                    InputDecoration(labelText: 'Ваша фамилия, имя и отчество')),
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
            child: Wrap(
              children: <Widget>[
                RaisedButton(
                  onPressed: () async {
                    User user = await APIRequest.authorisation(
                        controllerName.text, controllerPassword.text);
                    CurriculumLoad test = CurriculumLoad();
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return test;
//                      return MainScreen(user);
                    }));
                    SharedPref().save('user', user);
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
