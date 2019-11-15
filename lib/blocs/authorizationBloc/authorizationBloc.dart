import 'package:bloc/bloc.dart';
import 'package:timetable_app/APIRequest.dart';
import 'package:timetable_app/blocs/authorizationBloc/authorizationEvent.dart';
import 'package:timetable_app/blocs/authorizationBloc/authorizationState.dart';

class AuthorizationBloc extends Bloc<AuthorizationEvent, AuthorizationState> {
  @override
  // TODO: implement initialState
  AuthorizationState get initialState => AuthorizationUnitialized();

  @override
  Stream<AuthorizationState> mapEventToState(AuthorizationEvent event) async* {
    if (event is TryAuthorization) {
      yield AuthorizationLoading();
    } else if (event is LoadAuthorization) {
      yield Authorized(
          await APIRequest.authorisation(event.name, event.password));
    } else if (event is ErrorAuthorization) {
      yield NotAuthorizated();
    }
  }
}
