import 'package:bloc/bloc.dart';
import 'package:timetable_app/Models/Universe.dart';
import 'package:timetable_app/blocs/universeBloc/universeEvent.dart';
import 'package:timetable_app/blocs/universeBloc/universeState.dart';

import '../../APIRequest.dart';

class UniversityBloc extends Bloc<UniversityEvent, UniversityState>{
  @override
  // TODO: implement initialState
  UniversityState get initialState => UniversityLoading();

  @override
  Stream<UniversityState> mapEventToState(UniversityEvent event) async* {
    if(event is UniversityLoad){
      List<University> list = await APIRequest.getUnivercity();
      yield UniversityLoaded(list);
    }
  }
}