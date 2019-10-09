import 'package:flutter/material.dart';

class Timetable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          textTheme: TextTheme(
            title: TextStyle(color: Colors.black, fontSize: 18),
//          subtitle: TextStyle(color: Colors.black),
          ),
          title: Text('Учебный план'),
          backgroundColor: Color.fromARGB(255, 255, 217, 122),
        ),
        body: Text('dsadasd'));
  }
}
