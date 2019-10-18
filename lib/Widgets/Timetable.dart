import 'package:flutter/material.dart';

class Timetable extends StatelessWidget {
  List<Widget> timeList = [
    Text('1'),
    Container(
        child: Text(
      '08:15',
      style: TextStyle(color: Colors.black45),
    )),
    Container(
        margin: EdgeInsets.fromLTRB(0, 40, 0, 0),
        child: Text(
          '09:45',
          style: TextStyle(color: Colors.black45),
        )),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
//      margin: EdgeInsets.all(20),
      children: <Widget>[
        Container(
          margin: EdgeInsets.fromLTRB(10, 10, 0, 0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: timeList),
                margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
              ),
              Container(
//                width: double.infinity,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Container(

                      margin: EdgeInsets.fromLTRB(20, 0, 0, 20),
                      decoration: BoxDecoration(
                        color: Colors.green,
                          borderRadius: BorderRadius.circular(4)

                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Группа',
                              style: TextStyle(
                                  color: Color.fromARGB(132, 255, 255, 255)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Дисциплина',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Color.fromARGB(100, 100, 100, 100),
                              borderRadius: BorderRadius.circular(30)
                            ),
                            margin: EdgeInsets.all(8),
//                            color: Color.fromARGB(100, 100, 100, 100),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                              'Преподаватель',
                              style: TextStyle(color: Colors.white),
                            ),
                                )
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        Divider(height: 0,),
      ],
    );
  }
}
