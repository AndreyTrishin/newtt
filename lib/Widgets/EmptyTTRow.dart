import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:timetable_app/Models/ScheduleElement.dart';

class EmptyTTRow extends StatelessWidget {
  double fontSize = 26;

  ScheduleCell scheduleCell;
  int numberLesson;

  EmptyTTRow(this.scheduleCell, this.numberLesson);

  @override
  Widget build(BuildContext context) {
    return Container(
//      padding: EdgeInsets.symmetric(vertical: ScreenUtil.getInstance().setHeight(5), horizontal: ScreenUtil.getInstance().setWidth(5)),

      height: ScreenUtil.getInstance().setHeight(245),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(ScreenUtil.getInstance().setWidth(30), 0, 0, 0),
                  width: ScreenUtil.getInstance().setWidth(70),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          numberLesson.toString(),
                          style: TextStyle(
                              fontSize:
                                  ScreenUtil.getInstance().setSp(fontSize)),
                        ),
                        Text(
                          scheduleCell.dateBegin.toString().substring(11, 16),
                          style: TextStyle(
                              fontSize:
                                  ScreenUtil.getInstance().setSp(fontSize),
                              color: Color.fromARGB(130, 0, 0, 0)),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0,
                              ScreenUtil.getInstance().setHeight(82), 0, 10),
                          child: Text(
                            scheduleCell.dateEnd.toString().substring(11, 16),
                            style: TextStyle(
                                fontSize:
                                    ScreenUtil.getInstance().setSp(fontSize),
                                color: Color.fromARGB(130, 0, 0, 0)),
                          ),
                        ),
                      ]),
                ),
                Container(
//                    margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                    child: Text(
                      'Свободная пара',
                      style: TextStyle(
                          fontSize: ScreenUtil.getInstance().setSp(fontSize),
                          color: Color.fromARGB(130, 0, 0, 0)),
                    ))
              ],
            ),
          ),
          Divider(),
        ],
      ),
    );
  }
}
