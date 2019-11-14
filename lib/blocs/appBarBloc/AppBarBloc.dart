import 'package:bloc/bloc.dart';
import 'package:timetable_app/Models/User.dart';
import 'package:timetable_app/blocs/appBarBloc/AppBarEvent.dart';
import 'package:timetable_app/blocs/appBarBloc/AppBarState.dart';

class AppBarBloc extends Bloc<AppBarEvent, AppBarState> {
  final User _user;

  AppBarBloc([this._user]);

  @override
  // TODO: implement initialState
  AppBarState get initialState => AppBarUnitialized();

  @override
  Stream<AppBarState> mapEventToState(AppBarEvent event) async* {
    if (event is AppBarPageChange) {
      if (event.newPage != 0) {
        yield AppBarPageChanged(event.newPage);
      }
    }
  }
}
