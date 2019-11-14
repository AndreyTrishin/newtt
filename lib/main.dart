import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:timetable_app/APIRequest.dart';
import 'package:timetable_app/Models/Universe.dart';
import 'package:timetable_app/Models/User.dart';
import 'package:timetable_app/Screens/TeacherScreen.dart';
import 'package:timetable_app/SharedPref.dart';

import 'Screens/MainScreen.dart';
import 'Screens/UniversityList.dart';
import 'blocs/authorizationBloc/authorizationBloc.dart';
import 'blocs/authorizationBloc/authorizationEvent.dart';
import 'blocs/authorizationBloc/authorizationState.dart';

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

class MyHomePage extends StatelessWidget {
  University university;

  _show(context, state) {

  }

  TextEditingController controllerName =
      TextEditingController(text: 'Суханов Андрей Сергеевич');
  TextEditingController controllerPassword =
      TextEditingController(text: '1234567t');
  TextEditingController controllerUniverse = TextEditingController();
  InputBorder inputBorder;

  AuthorizationBloc _aithorizationBloc;

  @override
  Widget build(BuildContext context) {
    _aithorizationBloc = AuthorizationBloc();
    ScreenUtil.instance = ScreenUtil(width: 1080, height: 1794)..init(context);
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
          margin: EdgeInsets.fromLTRB(
              0, ScreenUtil.getInstance().setHeight(200), 0, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: ScreenUtil.getInstance().setWidth(20)),
                padding: EdgeInsets.symmetric(
                    horizontal: ScreenUtil.getInstance().setWidth(10),
                    vertical: ScreenUtil.getInstance().setHeight(10)),
                child: TextFormField(
                  readOnly: true,
                  controller: controllerUniverse,
                  decoration: InputDecoration(
//                    hoverColor: Colors.black,
                      suffixIcon: Icon(Icons.arrow_drop_down),
                      labelText: 'Название ВУЗа'),
                  onTap: () async {
                    university = await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UniversityList())) as University;
                    controllerUniverse.text = university.name;
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: ScreenUtil.getInstance().setWidth(20)),
                padding: EdgeInsets.symmetric(
                    horizontal: ScreenUtil.getInstance().setWidth(10),
                    vertical: ScreenUtil.getInstance().setHeight(10)),
                child: TextField(
                    cursorColor: Colors.red,
                    controller: controllerName,
                    decoration: InputDecoration(
                        focusedBorder: inputBorder,
                        labelText: 'Ваша фамилия, имя и отчество')),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: ScreenUtil.getInstance().setWidth(20)),
                padding: EdgeInsets.symmetric(
                    horizontal: ScreenUtil.getInstance().setWidth(10),
                    vertical: ScreenUtil.getInstance().setHeight(10)),
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
                  onPressed: () {
                    _aithorizationBloc..add(TryAuthorization());
                    APIRequest.idServer = university.id == 1 ? 0 : university.id;

//                        User user = await APIRequest.authorisation(
//                            controllerName.text, controllerPassword.text);
//                        print(current);
//                    CurriculumLoad test = CurriculumLoad();
//                    SharedPref().save('user', user);
                  },
                  child: Text(
                    'ВОЙТИ',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(ScreenUtil.getInstance().setWidth(20)),
                alignment: Alignment.centerRight,
                child: BlocBuilder(
                  bloc: _aithorizationBloc,
                  // ignore: missing_return
                  builder: (context, state) {
                    if (state is AuthorizationLoading) {
                      _aithorizationBloc
                        ..add(LoadAuthorization(
                            controllerName.text, controllerPassword.text));
                      return CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.red),);
                    } else if (state is Authorized) {
                      if(state.user!=null){
                        SchedulerBinding.instance.addPostFrameCallback((_) {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text('Выберите роль пользователя'),
                                  actions: <Widget>[
                                    FlatButton(
                                      child: Text(
                                        'Обучающийся',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      onPressed: () {
                                        Navigator.pushReplacement(context,
                                            MaterialPageRoute(builder: (context) {
                                              state.user.currentRole = 'Обучающийся';
                                              return MainScreen(state.user);
                                            }));
                                      },
                                      highlightColor: Color.fromARGB(30, 0, 0, 0),
                                    ),
                                    FlatButton(
                                      child: Text(
                                        'Преподаватель',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      onPressed: () {
                                        Navigator.pushReplacement(context,
                                            MaterialPageRoute(builder: (context) {
                                              state.user.currentRole = 'Преподаватель';
                                              return TeacherScreen(state.user);
                                            }));
                                      },
                                      highlightColor: Color.fromARGB(30, 0, 0, 0),
                                    ),
                                  ],
                                );
                              });
                        });
                        return Container();
                      } else{
                        _aithorizationBloc..add(ErrorAuthorization());

                        return Text('Ошибка авторизации');
                      }

                    } else if (state is NotAuthorizated) {
                      return Text('Ошибка авторизации');
                    } else {
                      return Container();
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
