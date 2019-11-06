import 'package:bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timetable_app/blocs/curriculumLoadBloc/curriculumLoadEvent.dart';

import '../../APIRequest.dart';
import 'curriculumLoadState.dart';

class CurriculumLoadBloc
    extends Bloc<CurriculumLoadEvent, CurriculumLoadState> {


  @override
  get initialState => CurriculumLoadLoading();

  @override
  Stream<CurriculumLoadState> mapEventToState(
      CurriculumLoadEvent event) async* {
    final currentState = state;
    if (event is LoadCurriculumLoad) {
      try {
        if (currentState is CurriculumLoadLoading) {
          final disciplines = await APIRequest.getCurriculumLoad('000000012');
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

//  Stream<CurriculumLoadState> _mapLoadCurriculumLoadToState() async* {
//    try {
//      final disciplines = await APIRequest.getCurriculumLoad('000000012');
//      yield CurriculumLoadLoaded(disciplines);
//    } catch (_) {
//      yield CurriculumLoadNotLoaded();
//    }
//  }
}
