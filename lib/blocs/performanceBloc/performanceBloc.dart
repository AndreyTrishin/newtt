import 'package:bloc/bloc.dart';
import 'package:timetable_app/APIRequest.dart';
import 'package:timetable_app/blocs/performanceBloc/performanceEvent.dart';
import 'package:timetable_app/blocs/performanceBloc/performanceState.dart';

class PerformanceBloc extends Bloc<PerformanceEvent, PerformanceState>{
  @override
  // TODO: implement initialState
  PerformanceState get initialState => PerformanceLoading();

  @override
  Stream<PerformanceState> mapEventToState(PerformanceEvent event) async* {
    if(event is PerformanceLoad){
      try{
        final performanceList = await APIRequest.getEducationalPerformance('000000036', '000000012');
        yield PerformanceLoaded(performanceList);
        return;
      } catch(_){
        yield PerformanceNotLoaded();
      }
    }
  }
}