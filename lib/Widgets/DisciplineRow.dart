import 'package:flutter/material.dart';
import 'package:timetable_app/Models/Discipline.dart';
import 'package:timetable_app/Screens/DisciplineInfo.dart';


// ignore: must_be_immutable
class DisciplineRow extends StatelessWidget {
  Discipline _discipline;
  double _fontSize = 16;

  DisciplineRow(this._discipline);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DisciplineInfo(_discipline)));
      },
      title: Container(
        child: Row(
          children: <Widget>[
            //Название дисциплины---------------------
            Container(
              margin: EdgeInsets.fromLTRB(10, 25, 0, 10),
              width: MediaQuery.of(context).size.width / 1.82,
              height: 33,
              child: Text(
                _discipline.subject,
                style: TextStyle(fontSize: _fontSize),
              ),
            ),
            //Тип и работа ----------------------
            Container(
                margin: EdgeInsets.fromLTRB(0, 20, 0, 10),
                width: MediaQuery.of(context).size.width / 4.5,
                height: 40,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                      child: Text(
                        _discipline.type,
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            fontSize: _fontSize,
                            color: _discipline.color,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      child: Text(
                        _discipline.isControl == true ? 'К/Р' : '',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 100, 100, 100)),
                        textAlign: TextAlign.right,
                      ),
                    )
                  ],
                )),
            Align(
              child: Container(
                margin: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width / 20,
                    vertical: 15),
                width: 10,
                height: 30,
                child: Icon(Icons.arrow_forward_ios),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
