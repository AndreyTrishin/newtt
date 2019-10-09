import 'package:flutter/material.dart';

import 'Discipline.dart';

// ignore: must_be_immutable
class DisciplineInfo extends StatelessWidget {
  Discipline _discipline;

  DisciplineInfo(Discipline discipline) : _discipline = discipline;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Учебный план'),
          iconTheme: IconThemeData(color: Colors.black),
          textTheme:
              TextTheme(title: TextStyle(color: Colors.black, fontSize: 18)),
          backgroundColor: Color.fromARGB(255, 255, 217, 122),
        ),
        body: ListView(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(20),
              child: Text(
                _discipline.name,
                style: TextStyle(fontSize: 20),
              ),
            ),
            Container(
                child: Row(
              children: <Widget>[
                Container(
                    margin: EdgeInsets.all(20), child: Icon(Icons.access_time)),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                          child: Text(
                              'Практические: ${_discipline.labHours} часов')),
                      Container(
                          child: Text('Лекции: ${_discipline.lecHours} часов')),
                    ],
                  ),
                ),
              ],
            )),
            Container(
                child: Row(
              children: <Widget>[
                Container(
                    margin: EdgeInsets.all(20),
                    child: Icon(Icons.check_circle_outline)),
                Container(
                  child: Text(
                    _discipline.type,
                    style: TextStyle(color: _discipline.color),
                  ),
                ),
              ],
            )),
            Container(
                child: _discipline.work == true
                    ? Row(
                        children: <Widget>[
                          Container(
                            child: Icon(Icons.receipt),
                            margin: EdgeInsets.all(20),
                          ),
                          Text(
                            _discipline.work == true ? 'Курсовая работа' : '',
                            style: TextStyle(
                                color: Color.fromARGB(255, 100, 100, 100)),
                          ),
                        ],
                      )
                    : null),
          ],
        ));
  }
}
