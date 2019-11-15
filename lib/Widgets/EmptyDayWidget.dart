import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmptyDayWidget extends StatelessWidget {
  double fontSize = 26;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      color: Color.fromARGB(255, 255, 249, 242),
      child: Row(children: <Widget>[
        Column(children: <Widget>[
          Container(
            height: ScreenUtil.getInstance().setHeight(222),
            margin: EdgeInsets.fromLTRB(
                ScreenUtil.getInstance().setWidth(30), 0, 0, 0),
            width: ScreenUtil.getInstance().setWidth(70),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                '1',
                style: TextStyle(
                    fontSize: ScreenUtil.getInstance().setSp(fontSize)),
              ),
              Text(
                '08:15',
                style: TextStyle(
                    fontSize: ScreenUtil.getInstance().setSp(fontSize)),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(
                    0, ScreenUtil.getInstance().setHeight(90), 0, 0),
                child: Text(
                  '09:45',
                  style: TextStyle(
                      fontSize: ScreenUtil.getInstance().setSp(fontSize)),
                ),
              ),
            ]),
          ),
          Container(
            height: ScreenUtil.getInstance().setHeight(222),
            margin: EdgeInsets.fromLTRB(
                ScreenUtil.getInstance().setWidth(30), 0, 0, 0),
            width: ScreenUtil.getInstance().setWidth(70),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                '2',
                style: TextStyle(
                    fontSize: ScreenUtil.getInstance().setSp(fontSize)),
              ),
              Text(
                '09:55',
                style: TextStyle(
                    fontSize: ScreenUtil.getInstance().setSp(fontSize)),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(
                    0, ScreenUtil.getInstance().setHeight(90), 0, 0),
                child: Text(
                  '11:25',
                  style: TextStyle(
                      fontSize: ScreenUtil.getInstance().setSp(fontSize)),
                ),
              ),
            ]),
          ),
          Container(
            height: ScreenUtil.getInstance().setHeight(222),
            margin: EdgeInsets.fromLTRB(
                ScreenUtil.getInstance().setWidth(30), 0, 0, 0),
            width: ScreenUtil.getInstance().setWidth(70),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                '3',
                style: TextStyle(
                    fontSize: ScreenUtil.getInstance().setSp(fontSize)),
              ),
              Text(
                '11:35',
                style: TextStyle(
                    fontSize: ScreenUtil.getInstance().setSp(fontSize)),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(
                    0, ScreenUtil.getInstance().setHeight(90), 0, 0),
                child: Text(
                  '13:05',
                  style: TextStyle(
                      fontSize: ScreenUtil.getInstance().setSp(fontSize)),
                ),
              ),
            ]),
          ),
          Container(
            height: ScreenUtil.getInstance().setHeight(222),
            margin: EdgeInsets.fromLTRB(
                ScreenUtil.getInstance().setWidth(30), 0, 0, 0),
            width: ScreenUtil.getInstance().setWidth(70),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                '4',
                style: TextStyle(
                    fontSize: ScreenUtil.getInstance().setSp(fontSize)),
              ),
              Text(
                '13:25',
                style: TextStyle(
                    fontSize: ScreenUtil.getInstance().setSp(fontSize)),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(
                    0, ScreenUtil.getInstance().setHeight(90), 0, 0),
                child: Text(
                  '14:55',
                  style: TextStyle(
                      fontSize: ScreenUtil.getInstance().setSp(fontSize)),
                ),
              ),
            ]),
          ),
          Container(
            height: ScreenUtil.getInstance().setHeight(222),
            margin: EdgeInsets.fromLTRB(
                ScreenUtil.getInstance().setWidth(30), 0, 0, 0),
            width: ScreenUtil.getInstance().setWidth(70),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                '5',
                style: TextStyle(
                    fontSize: ScreenUtil.getInstance().setSp(fontSize)),
              ),
              Text(
                '15:05',
                style: TextStyle(
                    fontSize: ScreenUtil.getInstance().setSp(fontSize)),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(
                    0, ScreenUtil.getInstance().setHeight(90), 0, 0),
                child: Text(
                  '16:35',
                  style: TextStyle(
                      fontSize: ScreenUtil.getInstance().setSp(fontSize)),
                ),
              ),
            ]),
          ),
        ]),
        Expanded(
            child: Align(
          child: Text('Свободный день'),
          alignment: Alignment.center,
        ))
      ]),
    );
  }
}
