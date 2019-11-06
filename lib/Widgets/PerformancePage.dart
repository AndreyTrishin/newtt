import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timetable_app/Models/Universe.dart';
import 'package:timetable_app/Widgets/PerformanceRow.dart';
import 'package:timetable_app/blocs/performanceBloc/performanceBloc.dart';
import 'package:timetable_app/blocs/performanceBloc/performanceEvent.dart';
import 'package:timetable_app/blocs/performanceBloc/performanceState.dart';

class PerformancePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 255, 217, 122),
        title: Text('Успеваемость', style: TextStyle(color: Colors.black),),
        leading: FlatButton(
          child: Icon(Icons.dehaze),
          onPressed: (){
            Scaffold.of(context).openDrawer();
          },
        ),
      ),
      body: BlocProvider(
        builder: (context) => PerformanceBloc()..add(PerformanceLoad()),
        child: BlocBuilder(
          bloc: PerformanceBloc()..add(PerformanceLoad()),
          builder: (context, state) {
            if (state is PerformanceLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is PerformanceLoaded) {
              return PageView(
                children: state.performanceList.map<Widget>((term) {
                  return ListView(
                    children: term.map<Widget>((mark) {
                      return PerformanceRow(mark);
                    }).toList(),
                  );
                }).toList(),
              );
            }
            if (state is PerformanceNotLoaded) {
              return Center(
                child: Text('Ошибка загрузки'),
              );
            }
          },
        ),
      ),
    );
  }
}
