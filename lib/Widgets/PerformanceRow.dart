import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:timetable_app/Models/MarkRecord.dart';


class PerformanceRow extends StatelessWidget {
  MarkRecord per;
  double fontSize = 26;

  PerformanceRow(this.per);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        title: Text(per.subject, style: TextStyle(fontSize: ScreenUtil.getInstance().setSp(fontSize)),),
        subtitle: Text(per.mark == '' ? '' : DateFormat('dd.MM.yy').format(per.date), style: TextStyle(fontSize: ScreenUtil.getInstance().setSp(fontSize)),),
        trailing: Container(
          padding: EdgeInsets.all(ScreenUtil.getInstance().setWidth(10)),
          margin: EdgeInsets.symmetric(horizontal: ScreenUtil.getInstance().setWidth(10), vertical: 0),
          color: Colors.white,
//          Red: 36
//          Green: 181
//        Blue: 111
          child: Text(per.mark, textAlign: TextAlign.center, style: TextStyle(fontSize: ScreenUtil.getInstance().setSp(fontSize), color: per.textColor),),
        ),
      ),
      color: per.color,
    );
  }
}
