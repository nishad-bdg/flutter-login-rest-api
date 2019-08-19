import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_api/blocs/authentication/authentication_bloc.dart';
import 'package:login_api/pages/home_page.dart';
import 'package:login_api/pages/login_page.dart';
import 'package:login_api/pages/splash_page.dart';
import 'package:login_api/services/repository.dart';

import 'blocs/authentication/bloc.dart';

void main() {
  final Repository repository = Repository();
  runApp(BlocProvider<AuthenticationBloc>(
    builder: (context) {
      return AuthenticationBloc(repository: repository)..dispatch(AppStarted());
    },
    child: MyApp(repository: repository),
  ));
}

class MyApp extends StatelessWidget {
  final Repository repository;
  MyApp({this.repository});


  @override
  Widget build(BuildContext context) {
    //final authenticationBloc = AuthenticationBloc(repository: repository);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Simple Auth App',
      theme: ThemeData(primaryColor: Colors.deepPurple),
      home: BlocBuilder(
        bloc: BlocProvider.of<AuthenticationBloc>(context),
        builder: (context,state){
          if(state is AuthenticationAuthenticated){
            return HomePage();
          }
          if(state is AuthenticationUnauthenticated){
            return LoginPage(repository: repository);
          }
          if(state is AuthenticationLoading){
            return Center(child: CircularProgressIndicator());
          }
          return SplashPage();

        },
      ),
    );
  }
}
