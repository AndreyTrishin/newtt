import 'package:flutter/material.dart';
import 'package:timetable_app/Models/ScheduleElement.dart';

class Timetable extends StatelessWidget {
  double fontSize = 13;
  ScheduleCell scheduleCell;

  Timetable(this.scheduleCell);

  @override
  Widget build(BuildContext context) {
    return Column(
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
                        scheduleCell.dateBegin.toString().substring(11, 16),
                        style: TextStyle(fontSize: fontSize),
                      ),
                      Text(
                        scheduleCell.dateEnd.toString().substring(11, 16),
                        style: TextStyle(fontSize: fontSize),
                      ),
                    ]),
              ),
              Container(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.fromLTRB(20, 0, 0, 20),
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(4)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              scheduleCell.lesson.academicGroup,
                              style: TextStyle(
                                  color: Color.fromARGB(132, 255, 255, 255),
                                  fontSize: fontSize),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              scheduleCell.lesson.subject,
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          Container(
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(100, 100, 100, 100),
                                  borderRadius: BorderRadius.circular(30)),
//                              margin: EdgeInsets.all(8),
//                            color: Color.fromARGB(100, 100, 100, 100),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  scheduleCell.lesson.teacher.teacherName,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: fontSize),
                                ),
                              )),
                        ],
                      ),
                    )
                  ],
                ),
              )
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
