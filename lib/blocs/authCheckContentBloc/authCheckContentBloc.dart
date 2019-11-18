import 'package:bloc/bloc.dart';

import 'authCheckContentEvent.dart';
import 'authCheckContentState.dart';

class AuthCheckContentBloc
    extends Bloc<AuthCheckContentEvent, AuthCheckContentState> {
  @override
  // TODO: implement initialState
  AuthCheckContentState get initialState => AuthCheckContentEmpty();

  @override
  Stream<AuthCheckContentState> mapEventToState(
      AuthCheckContentEvent event) async* {
    if (event is AuthCheckContentChange) {
      if (event.university == null ||
          event.university == '' ||
          event.name == null ||
          event.name == '' ||
          event.password == null ||
          event.password == '') {
        yield AuthCheckContentEmpty();
      } else {
        yield AuthCheckContentNotEmpty(
            event.university, event.name, event.password);
      }
    }
  }
}
