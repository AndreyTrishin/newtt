import 'package:bloc/bloc.dart';
import 'package:timetable_app/blocs/curriculumLoadEvent.dart';
import 'package:timetable_app/blocs/curriculumLoadState.dart';

import '../APIRequest.dart';

class CurriculumLoadBloc
    extends Bloc<CurriculumLoadEvent, CurriculumLoadState> {


  @override
  // TODO: implement initialState
  get initialState => CurriculumLoadLoading();



  //todo: реализовать бизнес-логику
  //todo: События и состояния по учебному плану вроде бы готовы
  @override
  Stream<CurriculumLoadState> mapEventToState(
      CurriculumLoadEvent event) async* {
//    final currentState = state;
//    if (event is LoadCurriculumLoad) {
      yield* _mapLoadCurriculumLoadToState();
//      try {
//        if (currentState is CurriculumLoadUninitialized) {
//          final disciplines = await APIRequest.getCurriculumLoad('000000012');
//          yield CurriculumLoadLoaded(disciplines);
//          return;
//        }
//      } catch (_) {
//        yield CurriculumLoadNotLoaded();
//      }
//    }
  }

  Stream<CurriculumLoadState> _mapLoadCurriculumLoadToState() async* {
    try {
      final disciplines = await APIRequest.getCurriculumLoad('000000012');
      yield CurriculumLoadLoaded(disciplines);
    } catch (_) {
      yield CurriculumLoadNotLoaded();
    }
  }



}