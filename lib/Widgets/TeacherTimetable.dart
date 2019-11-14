import 'package:flutter/material.dart';
import 'package:timetable_app/Models/ScheduleElement.dart';
import 'package:timetable_app/Screens/TimeTableInfo.dart';

class TeacherTimetable extends StatelessWidget{


  double fontSize = 26;
  int numberLesson;
  ScheduleCell scheduleCell;

  TeacherTimetable(this.scheduleCell, this.numberLesson);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      height: 110,
      child: Column(
        children: <Widget>[
          Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 30,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          numberLesson.toString(),
                          style: TextStyle(fontSize: fontSize),
                        ),
                        Text(
                          scheduleCell.dateBegin.toString().substring(11, 16),
                          style: TextStyle(fontSize: fontSize),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 55, 0, 0),
                          child: Text(
                            scheduleCell.dateEnd.toString().substring(11, 16),
                            style: TextStyle(fontSize: fontSize),
                          ),
                        ),
                      ]),
                ),
                Container(
                  width: MediaQuery.of(context).size.width - 50,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.fromLTRB(10, 0, 0, 10),
                    decoration: BoxDecoration(
                        color: scheduleCell.lesson.color,
                        borderRadius: BorderRadius.circular(4)),
                    child: ListTile(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return TimetableInfo(scheduleCell);
                        }));
                      },
                      trailing: Container(
                        margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Text(scheduleCell.lesson.lessonType.substring(0, 3).toUpperCase(),
                              style: TextStyle(
                                  color: Colors.white, fontSize: fontSize),),
                            Container(
                                margin: EdgeInsets.fromLTRB(0, 18, 0, 0),
                                child: Text(scheduleCell.lesson.classroom != null
                                    ? scheduleCell.lesson.classroom.classroomName
                                    : '',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: fontSize),)),
                          ],
                        ),
                      ),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(
                              scheduleCell.lesson.subject,
                              style: TextStyle(
                                  color: Colors.white, fontSize: fontSize),
                            ),
                          ),
                          Container(
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(100, 100, 100, 100),
                                  borderRadius: BorderRadius.circular(30)),
//                              margin: EdgeInsets.all(8),
//                            color: Color.fromARGB(100, 100, 100, 100),
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(
                                  scheduleCell.lesson.academicGroup,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: fontSize),
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
          Divider(
            height: 0,
          ),
        ],
      ),
    );
  }

}