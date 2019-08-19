import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_api/blocs/authentication/bloc.dart';
import 'package:login_api/blocs/login/bloc.dart';
import 'package:login_api/services/repository.dart';

import 'login_form.dart';

class LoginPage extends StatelessWidget {
  final Repository repository;
  LoginPage({this.repository});

  @override
  Widget build(BuildContext context) {
    LoginBloc loginBloc = LoginBloc(
        repository: repository,
        authenticationBloc: BlocProvider.of<AuthenticationBloc>(context));
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Login Page"),
      ),
      body: BlocProvider(
        builder: (context) => loginBloc,
        child: LoginForm(),
      ),
    );
  }
}
