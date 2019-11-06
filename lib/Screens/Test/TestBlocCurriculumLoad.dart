import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timetable_app/Models/Universe.dart';
import 'package:timetable_app/Widgets/DisciplineRow.dart';
import 'package:timetable_app/blocs/curriculumLoadBloc/curriculumLoadBloc.dart';
import 'package:timetable_app/blocs/curriculumLoadBloc/curriculumLoadState.dart';

class CurriculumLoad extends StatefulWidget {
  @override
  _CurriculumLoadState createState() => _CurriculumLoadState();
}

class _CurriculumLoadState extends State<CurriculumLoad> {
  CurriculumLoadBloc _curriculumLoadBloc;

  @override
  void initState() {
    super.initState();
    _curriculumLoadBloc = BlocProvider.of<CurriculumLoadBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurriculumLoadBloc, CurriculumLoadState>(
      bloc: _curriculumLoadBloc,
      builder: (context, state) {
        print(state);
//        LoadCurriculumLoad();


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
    );
  }

  @override
  void dispose() {
//    _curriculumLoadBloc.close();
    super.dispose();
  }
}
