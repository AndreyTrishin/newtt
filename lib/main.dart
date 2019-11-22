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
import 'package:timetable_app/blocs/passwordBloc/passwordBloc.dart';
import 'package:timetable_app/blocs/passwordBloc/passwordEvent.dart';

import 'Screens/MainScreen.dart';
import 'Screens/UniversityList.dart';
import 'blocs/authCheckContentBloc/authCheckContentState.dart';
import 'blocs/authorizationBloc/authorizationBloc.dart';
import 'blocs/authorizationBloc/authorizationEvent.dart';
import 'blocs/authorizationBloc/authorizationState.dart';
import 'blocs/passwordBloc/passwordState.dart';

main() async {
  User user;
  try {
    user = User.fromJson(await SharedPref().read('user'));
  } catch (_) {
    user = null;
  }
 runApp(MaterialApp(
    title: 'Университет',
    home: MyHomePage(user),
//    home: user == null ? MyHomePage() : MainScreen(user),
    color: Colors.amberAccent,
  ));
}

class MyHomePage extends StatelessWidget {
  User _user;
  MyHomePage(this._user);
  TextEditingController controllerUniversity = TextEditingController();

  TextEditingController controllerName = TextEditingController(text: 'Забродина Дарья Сергеевна');

  TextEditingController controllerPassword = TextEditingController(text: '31694115');

  AuthorizationBloc _authorizationBloc;

  University university;

  PasswordBloc _passwordBloc;

  bool passwordStatus = true;

  @override
  Widget build(BuildContext context) {
    _passwordBloc = PasswordBloc();
    _authorizationBloc = AuthorizationBloc();
    ScreenUtil.instance = ScreenUtil(width: 1080, height: 1794)..init(context);
// TODO: implement build
    return
//      _user == null ?
      Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('res/background_login_page.png'),
                fit: BoxFit.cover)),
        child: Container(
          padding: EdgeInsets.fromLTRB(
              ScreenUtil.getInstance().setWidth(100),
              ScreenUtil.getInstance().setHeight(300),
              ScreenUtil.getInstance().setWidth(100),
              0),
          child: Column(
            children: <Widget>[
              Theme(
                data: ThemeData(
                  primaryColor: Colors.red,
                ),
                child: BlocBuilder(
                  bloc: _authorizationBloc,
                  builder: (context, state) {
                    if (state is ChangedUniversity) {
                      return Theme(
                        data: ThemeData(canvasColor: Colors.red),
                        child: TextFormField(
                          controller: controllerUniversity,
                          decoration:
                              InputDecoration(labelText: 'Название ВУЗа'),
                          readOnly: true,
                          onTap: () async {
                            var un;
                            SchedulerBinding.instance
                                .addPostFrameCallback((_) async {
                              un = await Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return UniversityList();
                              }));
                              university = un;
                              controllerUniversity.text = university.name;
                              _authorizationBloc
                                ..add(ChangeUniversity(
                                    university,
                                    controllerName.text,
                                    controllerPassword.text));
                            });
                          },
                        ),
                      );
                    } else {
                      return TextFormField(
                        controller: controllerUniversity,
                        decoration: InputDecoration(labelText: 'Название ВУЗа'),
                        readOnly: true,
                        onChanged: (value) {
                          _authorizationBloc
                            ..add(ChangeUniversity(university,
                                controllerName.text, controllerPassword.text));
                        },
                        onTap: () async {
                          SchedulerBinding.instance
                              .addPostFrameCallback((_) async {
                            university = await Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return UniversityList();
                            }));
                            controllerUniversity.text = university.name;
                          });
                        },
                      );
                    }
                  },
                ),
              ),
              Theme(
                data: ThemeData(
                  primaryColor: Colors.red,
                ),
                child: TextFormField(
                  cursorColor: Colors.red,
                  controller: controllerName,
                  decoration: InputDecoration(
                      labelText: 'Ваши фамилия, имя и отчество',
                      border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.red))),
                  onChanged: (value) {
                    _authorizationBloc
                      ..add(ChangeUniversity(university, controllerName.text,
                          controllerPassword.text));
                  },
                ),
              ),
              Theme(
                data: ThemeData(
                  primaryColor: Colors.red,
                ),
                child: BlocBuilder(
                  bloc: _passwordBloc,
                  builder: (context, state) {
                    if (state is PasswordOpen) {
                      return TextFormField(
                        controller: controllerPassword,
                        decoration: InputDecoration(
                            labelText: 'Пароль',
                            suffixIcon: Container(
                              width: ScreenUtil.getInstance().setWidth(40),
                              child: FlatButton(
                                shape: CircleBorder(),
                                onPressed: () {
                                  passwordStatus = true;
                                  _passwordBloc
                                    ..add(PasswordStatusChange(passwordStatus,
                                        controllerPassword.text));
                                },
                                child: Image.asset(
                                  'res/ic_pass_eye_open_24dp_red.png',
                                  fit: BoxFit.scaleDown,
                                ),
                              ),
                            )),
                        onChanged: (value) {
                          _passwordBloc
                            ..add(PasswordStatusChange(
                                true, controllerPassword.text));
                          _authorizationBloc
                            ..add(ChangeUniversity(university,
                                controllerName.text, controllerPassword.text));
                        },
                      );
                    } else if (state is PasswordClose) {
                      return TextFormField(
                        obscureText: true,
                        controller: controllerPassword,
                        decoration: InputDecoration(
                            labelText: 'Пароль',
                            suffixIcon: Container(
                              width: ScreenUtil.getInstance().setWidth(40),
                              child: FlatButton(
                                shape: CircleBorder(),
                                onPressed: () {
                                  passwordStatus = false;
                                  _passwordBloc
                                    ..add(PasswordStatusChange(passwordStatus,
                                        controllerPassword.text));
                                },
                                child: Image.asset(
                                  'res/ic_pass_eye_closed_24dp_red.png',
                                  fit: BoxFit.scaleDown,
                                ),
                              ),
                            )),
                        onChanged: (value) {
                          _passwordBloc
                            ..add(PasswordStatusChange(
                                passwordStatus, controllerPassword.text));
                          _authorizationBloc
                            ..add(ChangeUniversity(university,
                                controllerName.text, controllerPassword.text));
                        },
                      );
                    } else {
                      return TextFormField(
                        controller: controllerPassword,
                        decoration: InputDecoration(
                          labelText: 'Пароль',
                        ),
                        onChanged: (value) {
                          _passwordBloc
                            ..add(PasswordStatusChange(
                                true, controllerPassword.text));
                          _authorizationBloc
                            ..add(ChangeUniversity(university,
                                controllerName.text, controllerPassword.text));
                        },
                      );
                    }
                  },
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                child: BlocBuilder(
                    bloc: _authorizationBloc
                      ..add(ChangeUniversity(university, controllerName.text,
                          controllerPassword.text)),
                    builder: (context, state) {
                      if (state is ChangedUniversity) {
                        return RaisedButton(
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
                        );
                      } else if (state is AuthCheckContentEmpty) {
                        return RaisedButton(
                          color: Colors.red,
                          child: Text(
                            'ВОЙТИ',
                            style: TextStyle(color: Colors.white),
                          ),
                        );
                      } else {
                        return RaisedButton(
                          color: Colors.red,
                          child: Text(
                            'ВОЙТИ',
                            style: TextStyle(color: Colors.white),
                          ),
                        );
                      }
                    }),
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
                      if (state.user.name != null) {
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
                                            return MainScreen(state.user);
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
                                            return TeacherScreen(state.user);
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
                            SharedPref().save('user', state.user);
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
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: BlocBuilder(
                      bloc: _authorizationBloc,
                      builder: (context, state) {
                        if (state is AuthorizationLoading) {
                          return RaisedButton(
                            color: Colors.red,
                            child: Text(
                              'ДЕМО',
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {
                              APIRequest.idServer = 0;
                              _authorizationBloc..add(TryAuthorization());
                            },
                          );
                        } else if (state is Authorized &&
                            state.user.name == 'Иван Иванов') {
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
                                            return MainScreen(state.user);
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
                                            return TeacherScreen(state.user);
                                          }));
                                        },
                                        highlightColor:
                                            Color.fromARGB(30, 0, 0, 0),
                                      ),
                                    ],
                                  );
                                });
                          });
                          return RaisedButton(
                            color: Colors.red,
                            child: Text(
                              'ДЕМО',
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {
                              APIRequest.idServer = 0;
                              _authorizationBloc..add(TryAuthorization());
                            },
                          );
                        } else {
                          return RaisedButton(
                            color: Colors.red,
                            child: Text(
                              'ДЕМО',
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {
                              APIRequest.idServer = 0;
                              _authorizationBloc..add(TryAuthorization());
                            },
                          );
                        }
                      }),
                ),
              )
            ],
          ),
        ),
      ),
    );
//    : MainScreen(_user);
  }
}
