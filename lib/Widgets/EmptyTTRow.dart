import 'package:flutter/material.dart';
import 'package:timetable_app/Models/ScheduleElement.dart';

class EmptyTTRow extends StatelessWidget {
  double fontSize = 13;

  ScheduleCell scheduleCell;

  EmptyTTRow(this.scheduleCell);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
//          margin: EdgeInsets.fromLTRB(10, 10, 0, 0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        scheduleCell.dateBegin.toString().substring(11, 16),
                        style: TextStyle(fontSize: fontSize),
                      ),
                      Text(
                        scheduleCell.dateEnd.toString().substring(11, 16),
                        style: TextStyle(fontSize: fontSize),
                      ),
                    ]),
              ),
              Container()
            ],
          ),
        ),
        Divider(
          height: 0,
        ),
      ],
    );
  }
}
