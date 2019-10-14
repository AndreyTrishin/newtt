import 'package:flutter/material.dart';

import 'Performance.dart';

class PerformanceRow extends StatelessWidget {
  Performance per;

  PerformanceRow(this.per);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        onTap: () {},
        title: Text(per.name),
        subtitle: Text('${per.date.day}.${per.date.month}.${per.date.year}'),
        trailing: Container(
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          margin: EdgeInsets.symmetric(horizontal: 5, vertical: 0),
          color: Colors.white,
          child: Text(per.value, textAlign: TextAlign.center,),
        ),
      ),
      color: per.color,
    );
  }
}
