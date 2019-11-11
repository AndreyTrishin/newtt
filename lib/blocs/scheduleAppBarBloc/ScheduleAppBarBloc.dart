import 'package:bloc/bloc.dart';
import 'package:timetable_app/blocs/scheduleAppBarBloc/ScheduleAppBarState.dart';
import 'package:timetable_app/blocs/scheduleAppBarBloc/scheduleAppBarEvent.dart';

class ScheduleAppBarBloc extends Bloc<ScheduleAppBarEvent, ScheduleAppBarState>{
  @override
  // TODO: implement initialState
  ScheduleAppBarState get initialState => ScheduleAppBarDateUnitialized();

  @override
  Stream<ScheduleAppBarState> mapEventToState(ScheduleAppBarEvent event) async* {
    if(event is ScheduleAppBarPageChange){
      yield ScheduleAppBarDateChanged(event.newDate);
    }
  }

}
