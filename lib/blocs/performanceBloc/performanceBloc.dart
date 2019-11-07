import 'package:bloc/bloc.dart';
import 'package:timetable_app/APIRequest.dart';
import 'package:timetable_app/Models/User.dart';
import 'package:timetable_app/blocs/performanceBloc/performanceEvent.dart';
import 'package:timetable_app/blocs/performanceBloc/performanceState.dart';

class PerformanceBloc extends Bloc<PerformanceEvent, PerformanceState>{

  User _user;

  PerformanceBloc(this._user);


  @override
  // TODO: implement initialState
  PerformanceState get initialState => PerformanceLoading();

  @override
  Stream<PerformanceState> mapEventToState(PerformanceEvent event) async* {
    if(event is PerformanceLoad){
      try{
        final performanceList = await APIRequest.getEducationalPerformance(_user.id, _user.recordbookId);
        yield PerformanceLoaded(performanceList);
        return;
      } catch(_){
        yield PerformanceNotLoaded();
      }
    }
  }
}