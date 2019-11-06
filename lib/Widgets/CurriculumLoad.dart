import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timetable_app/Models/Universe.dart';
import 'package:timetable_app/Widgets/DisciplineRow.dart';
import 'package:timetable_app/blocs/curriculumLoadBloc/curriculumLoadBloc.dart';
import 'package:timetable_app/blocs/curriculumLoadBloc/curriculumLoadEvent.dart';
import 'package:timetable_app/blocs/curriculumLoadBloc/curriculumLoadState.dart';

class CurriculumLoad extends StatefulWidget {
  @override
  _CurriculumLoadState createState() => _CurriculumLoadState();
}

class _CurriculumLoadState extends State<CurriculumLoad> {
//  CurriculumLoadBloc _curriculumLoadBloc;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 255, 217, 122),
        title: Text('Учебный план', style: TextStyle(color: Colors.black),),
        leading: FlatButton(
          child: Icon(Icons.dehaze),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        ),
      ),
      body: BlocProvider(
        builder: (context) => CurriculumLoadBloc()..add(LoadCurriculumLoad()),
        child: BlocBuilder<CurriculumLoadBloc, CurriculumLoadState>(
          bloc: CurriculumLoadBloc()..add(LoadCurriculumLoad()),
          builder: (context, state) {
            if (state is CurriculumLoadLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is CurriculumLoadLoaded) {
              return PageView(
                children: state.disciplines.map<Widget>((term) {
                  return ListView(
                    children: term.values.map<Widget>((discipline) {
                      return DisciplineRow(discipline);
                    }).toList(),
                  );
                }).toList(),
              );
            } else if (state is CurriculumLoadNotLoaded) {
              return Center(
                child: Text('Ошибка загрузки'),
              );
            } else {
              return Center(
                child: Text('Ошибка'),
              );
            }
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
//    _curriculumLoadBloc.close();
    super.dispose();
  }
}
