import 'package:bloc/bloc.dart';
import 'package:timetable_app/APIRequest.dart';
import 'package:timetable_app/blocs/authorizationBloc/authorizationEvent.dart';
import 'package:timetable_app/blocs/authorizationBloc/authorizationState.dart';

class AuthorizationBloc extends Bloc<AuthorizationEvent, AuthorizationState> {
  @override
  AuthorizationState get initialState => CanNotAuth();

  @override
  Stream<AuthorizationState> mapEventToState(AuthorizationEvent event) async* {
    if (event is TryAuthorization) {
      yield AuthorizationLoading();
    } else if (event is LoadAuthorization) {
      yield Authorized(
          await APIRequest.authorisation(event.name, event.password));
    } else if (event is ErrorAuthorization) {
      yield NotAuthorizated();
    } else if(event is ChangeUniversity){
      if(event.university == null || event.name == '' || event.password == ''){
        yield CanNotAuth();
      } else{
        yield ChangedUniversity(event.university);
      }
    }
  }
}
