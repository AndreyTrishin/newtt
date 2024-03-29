import 'package:bloc/bloc.dart';
import 'package:timetable_app/blocs/passwordBloc/passwordEvent.dart';
import 'package:timetable_app/blocs/passwordBloc/passwordState.dart';

class PasswordBloc extends Bloc<PasswordEvent, PasswordState> {
  final String password;


  PasswordBloc(this.password);
  @override
  // TODO: implement initialState
  PasswordState get initialState => PasswordUninitialized();

  @override
  Stream<PasswordState> mapEventToState(PasswordEvent event) async* {
    if (event is PasswordStatusChange) {
      if(event.password != ''){
        if (event.status) {
          yield PasswordClose(event.password);
        } else {
          yield PasswordOpen(event.password);
        }
      } else {
        yield PasswordEmpty();
      }
    }
  }
}
