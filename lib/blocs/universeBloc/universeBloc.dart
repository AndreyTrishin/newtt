import 'package:bloc/bloc.dart';
import 'package:timetable_app/Models/Universe.dart';
import 'package:timetable_app/blocs/universeBloc/universeEvent.dart';
import 'package:timetable_app/blocs/universeBloc/universeState.dart';

import '../../APIRequest.dart';

class UniverseBloc extends Bloc<UniverseEvent, UniverseState>{
  @override
  // TODO: implement initialState
  UniverseState get initialState => UniverseLoading();

  @override
  Stream<UniverseState> mapEventToState(UniverseEvent event) async* {
    if(event is UniverseLoad){
      List<Universe> list = await APIRequest.getUnivercity();
      yield UniverseLoaded(list);
    }
  }
}