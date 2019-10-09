import 'package:flutter/material.dart';

import 'Performance.dart';

class PerformanceRow extends StatelessWidget {
  Performance per;

  PerformanceRow(this.per);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: ListTile(
        onTap: () {},
        title: Text(per.name),
        subtitle: Text('${per.date.day}.${per.date.month}.${per.date.year}'),
        trailing: Container(
          height: 30,
          width: 70,
          padding: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
          color: Colors.white,
          child: Text(per.value, textAlign: TextAlign.center,),
        ),
      ),
      color: per.color,
    );
  }
}
