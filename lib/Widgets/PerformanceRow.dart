import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timetable_app/Models/MarkRecord.dart';


class PerformanceRow extends StatelessWidget {
  MarkRecord per;
  double fontSize = 13;

  PerformanceRow(this.per);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        onTap: () {},
        title: Text(per.subject, style: TextStyle(fontSize: fontSize),),
        subtitle: Text(per.mark == '' ? '' : DateFormat('dd.MM.yy').format(per.date), style: TextStyle(fontSize: fontSize),),
        trailing: Container(
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          margin: EdgeInsets.symmetric(horizontal: 5, vertical: 0),
          color: Colors.white,
          child: Text(per.mark, textAlign: TextAlign.center, style: TextStyle(fontSize: fontSize),),
        ),
      ),
      color: per.color,
    );
  }
}
