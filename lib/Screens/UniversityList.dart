import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timetable_app/Widgets/LoadWidget.dart';
import 'package:timetable_app/blocs/universeBloc/universeBloc.dart';
import 'package:timetable_app/blocs/universeBloc/universeEvent.dart';
import 'package:timetable_app/blocs/universeBloc/universeState.dart';

class UniversityList extends StatelessWidget {
  UniversityBloc _universityBloc;
  @override
  Widget build(BuildContext context) {
    _universityBloc = UniversityBloc()..add(UniversityLoad());
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 255, 217, 122),
          leading: FlatButton(
            child: Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: BlocBuilder(
          bloc: _universityBloc,
          builder: (context, state) {
            if (state is UniversityLoading) {
              return Center(
                child: LoadWidget(),
              );
            } else if (state is UniversityLoaded) {
              return ListView(
                children: state.universityList.map((university) {
                  return ListTile(
                    onTap: (){
                      Navigator.pop(context, university);
                    },
                    title: Text(university.name),
                    subtitle: Text(university.city),
                  );
                }).toList(),
              );
            } else{
              return Center(child: Text('Ошибка загрузки'),);
            }
          },
        ));
  }
}
