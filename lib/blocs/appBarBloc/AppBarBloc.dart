import 'package:bloc/bloc.dart';
import 'package:timetable_app/Models/User.dart';
import 'package:timetable_app/blocs/appBarBloc/AppBarEvent.dart';
import 'package:timetable_app/blocs/appBarBloc/AppBarState.dart';

class AppBarBloc extends Bloc<AppBarEvent, AppBarState> {
  final User _user;
  final List list;

  AppBarBloc([this._user, this.list]);

  @override
  // TODO: implement initialState
  AppBarState get initialState => AppBarUnitialized();

  @override
  Stream<AppBarState> mapEventToState(AppBarEvent event) async* {
    if (event is AppBarPageChange && list != null) {
      if (event.newPage != 0 && event.newPage != list.length + 1) {
        yield AppBarPageChanged(event.newPage);
      } else {
        yield AppBarPageChanged(event.newPage);
      }
    }
  }
}
