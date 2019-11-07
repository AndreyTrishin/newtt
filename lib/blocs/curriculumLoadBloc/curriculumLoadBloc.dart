import 'package:bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timetable_app/Models/User.dart';
import 'package:timetable_app/blocs/curriculumLoadBloc/curriculumLoadEvent.dart';

import '../../APIRequest.dart';
import 'curriculumLoadState.dart';

class CurriculumLoadBloc
    extends Bloc<CurriculumLoadEvent, CurriculumLoadState> {

  User _user;

  CurriculumLoadBloc(this._user);

  @override
  get initialState => CurriculumLoadLoading();

  @override
  Stream<CurriculumLoadState> mapEventToState(
      CurriculumLoadEvent event) async* {
    final currentState = state;
    if (event is LoadCurriculumLoad) {
      try {
        if (currentState is CurriculumLoadLoading) {
          final disciplines = await APIRequest.getCurriculumLoad(_user.curriculumId);
          yield CurriculumLoadLoaded(disciplines: disciplines);
          return;
        }
      } catch (_) {
        yield CurriculumLoadNotLoaded();
      }
    }
  }

  @override
  Stream<CurriculumLoadState> transformEvents(
      Stream<CurriculumLoadEvent> events,
      Stream<CurriculumLoadState> next(CurriculumLoadEvent event)) {
    return super.transformEvents(
      (events as Observable<CurriculumLoadEvent>).debounceTime(
        Duration(milliseconds: 500),
      ),
      next,
    );
  }
}
