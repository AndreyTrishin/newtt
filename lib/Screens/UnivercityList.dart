import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timetable_app/blocs/universeBloc/universeBloc.dart';
import 'package:timetable_app/blocs/universeBloc/universeEvent.dart';
import 'package:timetable_app/blocs/universeBloc/universeState.dart';

class UnivercityList extends StatelessWidget {
  UniverseBloc _universeBloc;
  @override
  Widget build(BuildContext context) {
    _universeBloc = UniverseBloc()..add(UniverseLoad());
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
          bloc: _universeBloc,
          builder: (context, state) {
            if (state is UniverseLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is UniverseLoaded) {
              return ListView(
                children: state.universeList.map((universe) {
                  return ListTile(
                    onTap: (){
                      Navigator.pop(context, universe.name);
                    },
                    title: Text(universe.name),
                    subtitle: Text(universe.city),
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
