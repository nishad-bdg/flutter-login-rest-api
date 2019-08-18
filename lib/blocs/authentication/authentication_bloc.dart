import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:login_api/services/repository.dart';
import './bloc.dart';
import 'package:meta/meta.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final Repository repository;
  AuthenticationBloc({@required this.repository}) : assert(repository != null);
  @override
  AuthenticationState get initialState => AuthenticationUninitialized();

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
   if(event is AppStarted){
     final bool hasToken = await repository.hasToken();
     if(hasToken){
       yield AuthenticationAuthenticated();
     }
     else{
       yield AuthenticationUnauthenticated();
     }
   }

    if(event is LoggedIn){
      yield AuthenticationLoading();
      await repository.persistToken(event.token);
      yield AuthenticationAuthenticated();
    }

    if(event is LoggedOut){
      yield AuthenticationLoading();
      await repository.deleteToken();
      yield AuthenticationUnauthenticated();
    }


  }
}
