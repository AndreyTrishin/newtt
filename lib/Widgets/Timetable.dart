import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:timetable_app/Models/ScheduleElement.dart';
import 'package:timetable_app/Screens/TimeTableInfo.dart';

class Timetable extends StatelessWidget {
  double fontSize = 26;
  int numberLesson;
  ScheduleCell scheduleCell;

  Timetable(this.scheduleCell, this.numberLesson);

  @override
  Widget build(BuildContext context) {
    return Container(
//      margin: EdgeInsets.all(ScreenUtil.getInstance().setWidth(5)),
      height: ScreenUtil.getInstance().setHeight(245),
      child: Column(
        children: <Widget>[
          Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(
                      ScreenUtil.getInstance().setWidth(30), 0, 0, 0),
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
                                  ScreenUtil.getInstance().setSp(fontSize)),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(
                              0, ScreenUtil.getInstance().setHeight(80), 0, 0),
                          child: Text(
                            scheduleCell.dateEnd.toString().substring(11, 16),
                            style: TextStyle(
                                fontSize:
                                    ScreenUtil.getInstance().setSp(fontSize)),
                          ),
                        ),
                      ]),
                ),
                Container(
                  width: MediaQuery.of(context).size.width - 50,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: ScreenUtil.getInstance().setHeight(10), horizontal: ScreenUtil.getInstance().setWidth(10)),
                    margin: EdgeInsets.symmetric(
                        horizontal: ScreenUtil.getInstance().setWidth(18)),
                    decoration: BoxDecoration(
                        color: scheduleCell.lesson.color,
                        borderRadius: BorderRadius.circular(4)),
                    child: ListTile(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return TimetableInfo(scheduleCell);
                        }));
                      },
                      trailing: Container(
                        margin: EdgeInsets.fromLTRB(0, ScreenUtil.getInstance().setWidth(20), 0, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              scheduleCell.lesson.lessonType
                                  .substring(0, 3)
                                  .toUpperCase(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize:
                                      ScreenUtil.getInstance().setSp(fontSize)),
                            ),
                            Container(
                                margin: EdgeInsets.fromLTRB(0,
                                    ScreenUtil.getInstance().setWidth(36), 0, 0),
                                child: Text(
                                  scheduleCell.lesson.classroom != null
                                      ? scheduleCell
                                          .lesson.classroom.classroomName
                                      : '',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: ScreenUtil.getInstance()
                                          .setSp(fontSize)),
                                )),
                          ],
                        ),
                      ),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: ScreenUtil.getInstance().setHeight(4), horizontal: ScreenUtil.getInstance().setWidth(4)),

                            child: Text(
                              scheduleCell.lesson.academicGroup,
                              style: TextStyle(
                                  color: Color.fromARGB(132, 255, 255, 255),
                                  fontSize:
                                      ScreenUtil.getInstance().setSp(20)),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: ScreenUtil.getInstance().setHeight(4), horizontal: ScreenUtil.getInstance().setWidth(4)),

                            child: Text(
                              scheduleCell.lesson.subject,
                              softWrap: false,
                              style: TextStyle(

                                  color: Colors.white,
                                  fontSize:
                                      ScreenUtil.getInstance().setSp(fontSize)),
                            ),
                          ),
                          Container(
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(100, 100, 100, 100),
                                  borderRadius: BorderRadius.circular(30)),
//                              margin: EdgeInsets.all(8),
//                            color: Color.fromARGB(100, 100, 100, 100),
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: ScreenUtil.getInstance().setHeight(4), horizontal: ScreenUtil.getInstance().setWidth(4)),

                                child: Text(
                                  scheduleCell.lesson.teacher.teacherName,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: ScreenUtil.getInstance()
                                          .setSp(fontSize)),
                                ),
                              )),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Divider(),
        ],
      ),
    );
  }
}
