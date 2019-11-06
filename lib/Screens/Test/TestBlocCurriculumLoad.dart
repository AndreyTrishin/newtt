import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timetable_app/Models/Universe.dart';
import 'package:timetable_app/Widgets/DisciplineRow.dart';
import 'package:timetable_app/blocs/curriculumLoadBloc.dart';
import 'package:timetable_app/blocs/curriculumLoadState.dart';

class TestBlocCurriculumLoad extends StatefulWidget {
//
//  User _user;
//
//  TestBlocCurriculumLoad(this._user);

  @override
  _TestBlocCurriculumLoadState createState() => _TestBlocCurriculumLoadState();
}

class _TestBlocCurriculumLoadState extends State<TestBlocCurriculumLoad> {
  CurriculumLoadBloc _curriculumLoadBloc;

  @override
  void initState() {
    super.initState();
    _curriculumLoadBloc = BlocProvider.of<CurriculumLoadBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocBuilder<CurriculumLoadBloc, CurriculumLoadState>(
        bloc: _curriculumLoadBloc,
        builder: (context, state) {
          print(state);

          if(state is CurriculumLoadLoading){
            return Center(child: CircularProgressIndicator(),);
          } else if(state is CurriculumLoadLoaded){
            return PageView(
              children: state.disciplines.map<Widget>((term){
                return ListView(
                  children: term.values.map<Widget>((discipline){
                    return DisciplineRow(discipline);
                  }).toList(),
                );
              }).toList(),
            );
          } else if (state is CurriculumLoadNotLoaded){
            return Center(child: Text('Ошибка загрузки'),);
          } else {
            return Center(child: Text('Ошибка'),);
          }
        },
      );
  }

  @override
  void dispose() {
    _curriculumLoadBloc.close();
    super.dispose();
  }

}
