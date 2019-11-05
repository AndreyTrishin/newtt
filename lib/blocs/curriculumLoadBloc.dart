import 'package:bloc/bloc.dart';
import 'package:timetable_app/Models/Discipline.dart';
import 'package:timetable_app/blocs/curriculumLoadEvent.dart';
import 'package:timetable_app/blocs/curriculumLoadState.dart';

import '../APIRequest.dart';

class CurriculumLoadBloc extends Bloc<CurriculumLoadEvent, CurriculumLoadState>{
  @override
  // TODO: implement initialState
  CurriculumLoadState get initialState => CurriculumLoadState();

  @override
  Stream<CurriculumLoadState> mapEventToState(CurriculumLoadState currentState, CurriculumLoadEvent event) async* {
    //todo: реализовать бизнес-логику
    //todo: События и состояния по учебному плану вроде бы готовы
    if (event is LoadCurriculumLoad)  {
//      yield* ;
    }
  }

  Future<List<List<Discipline>>> _mapLoadCurriculumLoadToState(int startIndex, int limit) async {
    try{
      final disciplines =  APIRequest.getCurriculumLoad('000000012');

    } catch (ex) {
      throw Exception('error fetching posts');
    }
  }


}