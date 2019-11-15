import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
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
//    home: MyHomePage(),
    home: user == null ? MyHomePage() : MainScreen(user),
    color: Colors.amberAccent,
  ));
}

//todo: сделать нормальную домашнюю страницу
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController controllerUniversity = TextEditingController();

  TextEditingController controllerName =
  TextEditingController(text: 'Забродина Дарья Сергеевна');

  TextEditingController controllerPassword =
  TextEditingController(text: '31694115');

  AuthorizationBloc _authorizationBloc;

  University university;

  @override
  Widget build(BuildContext context) {
//    _authCheckContentBloc = AuthCheckContentBloc();
    _authorizationBloc = AuthorizationBloc();
    ScreenUtil.instance = ScreenUtil(width: 1080, height: 1794)
      ..init(context);
// TODO: implement build
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('res/background_login_page.png'),
                fit: BoxFit.cover)),
        child: Container(
          padding: EdgeInsets.fromLTRB(
              ScreenUtil.getInstance().setWidth(50),
              ScreenUtil.getInstance().setHeight(300),
              ScreenUtil.getInstance().setWidth(50),
              0),
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: controllerUniversity,
                decoration: InputDecoration(labelText: 'Название ВУЗа'),
                readOnly: true,

                onTap: () async {
                  university = await Navigator.push(context,
                      MaterialPageRoute(builder: (context) {
                        return UniversityList();
                      }));
                  setState(() {
                    controllerUniversity.text = university.name;
                  });
                },
              ),
              TextFormField(
                controller: controllerName,
                decoration:
                InputDecoration(labelText: 'Ваши фамилия, имя и отчество'),
//                onSaved: (value) {
//                  _authCheckContentBloc
//                    ..add(AuthCheckContentChange(controllerUniversity.text,
//                        value, controllerPassword.text));
//                },
              ),
              TextField(
                obscureText: true,
                controller: controllerPassword,
                decoration: InputDecoration(labelText: 'Пароль'),
//                onChanged: (value) {
//                  _authCheckContentBloc
//                    ..add(AuthCheckContentChange(
//                        controllerUniversity.text, controllerName.text, value));
//                },
              ),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 30),
                  alignment: Alignment.centerRight,
                  child: RaisedButton(
                    color: Colors.red,
                    onPressed: () {
                      _authorizationBloc..add(TryAuthorization());
                      try {
                        APIRequest.idServer =
                        university.id == 1 ? 0 : university.id;
                      } catch (_) {
                        _authorizationBloc..add(ErrorAuthorization());
                      }
                    },
                    child: Text(
                      'ВОЙТИ',
                      style: TextStyle(color: Colors.white),
                    ),
                  )
//                BlocBuilder(
//                    bloc: _authCheckContentBloc,
//                    builder: (context, state) {
//                      print(state);
//                      if (state is AuthCheckContentNotEmpty) {
//                        return RaisedButton(
//                          color: Colors.red,
//                          onPressed: () {
//                            _authorizationBloc..add(TryAuthorization());
//                            try {
//                              APIRequest.idServer =
//                                  university.id == 1 ? 0 : university.id;
//                            } catch (_) {
//                              _authorizationBloc..add(ErrorAuthorization());
//                            }
//                          },
//                          child: Text(
//                            'ВОЙТИ',
//                            style: TextStyle(color: Colors.white),
//                          ),
//                        );
//                      } else if (state is AuthCheckContentEmpty) {
//                        return RaisedButton(
//                          color: Colors.red,
//                          child: Text(
//                            'ВОЙТИ',
//                            style: TextStyle(color: Colors.white),
//                          ),
//                        );
//                      } else {
//                        return RaisedButton(
//                          color: Colors.red,
//                          child: Text(
//                            'ВОЙТИ',
//                            style: TextStyle(color: Colors.white),
//                          ),
//                        );
//                      }
//                    }),
              ),
              Container(
                margin: EdgeInsets.all(ScreenUtil.getInstance().setWidth(20)),
                alignment: Alignment.centerRight,
                child: BlocBuilder(
                  bloc: _authorizationBloc,
                  builder: (context, state) {
                    if (state is AuthorizationLoading) {
                      _authorizationBloc
                        ..add(LoadAuthorization(
                            controllerName.text, controllerPassword.text));
                      return CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                      );
                    } else if (state is Authorized) {
                      if (state.user != null) {
                        if (state.user.currentRole == null) {
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
                                              MaterialPageRoute(
                                                  builder: (context) {
                                                    state.user.currentRole =
                                                    'Обучающийся';
                                                    return MainScreen(
                                                        state.user);
                                                  }));
                                        },
                                        highlightColor:
                                        Color.fromARGB(30, 0, 0, 0),
                                      ),
                                      FlatButton(
                                        child: Text(
                                          'Преподаватель',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        onPressed: () {
                                          Navigator.pushReplacement(context,
                                              MaterialPageRoute(
                                                  builder: (context) {
                                                    state.user.currentRole =
                                                    'Преподаватель';
                                                    return TeacherScreen(
                                                        state.user);
                                                  }));
                                        },
                                        highlightColor:
                                        Color.fromARGB(30, 0, 0, 0),
                                      ),
                                    ],
                                  );
                                });
                          });
                        } else if (state.user.currentRole == 'Обучающийся') {
                          SchedulerBinding.instance.addPostFrameCallback((_) {
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context) {
                                  return MainScreen(state.user);
                                }));
                          });
                        } else if (state.user.currentRole == 'Преподаватель') {
                          SchedulerBinding.instance.addPostFrameCallback((_) {
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context) {
                                  return TeacherScreen(state.user);
                                }));
                          });
                        }

                        return Container();
                      } else {
//                        _authorizationBloc..add(ErrorAuthorization());

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
