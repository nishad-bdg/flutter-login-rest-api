import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:login_api/blocs/authentication/authentication_bloc.dart';
import 'package:login_api/blocs/authentication/bloc.dart';
import 'package:login_api/services/repository.dart';
import './bloc.dart';
import 'package:meta/meta.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final Repository repository;
  final AuthenticationBloc authenticationBloc;

  LoginBloc({@required this.repository, @required this.authenticationBloc})
      : assert(repository != null),
        assert(repository != null);

  @override
  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LoginButtonPressedEvent) {
      yield LoginLoading();
      try{
        final token = await repository.authenticate(
          username: event.username,
          password: event.password
        );
        authenticationBloc.dispatch(LoggedIn(token: token));
        yield LoginInitial();
      }
      catch(error){
        yield LoginFailure(error: error.toString());
      }
    }
  }
}
