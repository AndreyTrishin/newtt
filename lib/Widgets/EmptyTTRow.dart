import 'package:flutter/material.dart';
import 'package:timetable_app/Models/ScheduleElement.dart';

class EmptyTTRow extends StatelessWidget {
  double fontSize = 13;

  ScheduleCell scheduleCell;
  int numberLesson;

  EmptyTTRow(this.scheduleCell, this.numberLesson);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      height: 110,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          numberLesson.toString(),
                          style: TextStyle(fontSize: fontSize),
                        ),
                        Text(
                          scheduleCell.dateBegin.toString().substring(11, 16),
                          style: TextStyle(fontSize: fontSize, color: Color.fromARGB(130, 0, 0, 0)),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 55, 0, 10),
                          child: Text(
                            scheduleCell.dateEnd.toString().substring(11, 16),
                            style: TextStyle(fontSize: fontSize, color: Color.fromARGB(130, 0, 0, 0)),
                          ),
                        ),
                      ]),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                    child: Text(
                  'Свободная пара',
                  style: TextStyle(fontSize: fontSize, color: Color.fromARGB(130, 0, 0, 0)),
                ))
              ],
            ),
          ),
          Divider(
            height: 0,
          ),
        ],
      ),
    );
  }
}
