import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_api/blocs/authentication/authentication_bloc.dart';
import 'package:login_api/blocs/authentication/bloc.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthenticationBloc authenticationBloc =
        BlocProvider.of<AuthenticationBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
      ),
      body: Center(
        child: Container(
          child: RaisedButton(
            child: Text("Logout"),
            onPressed: () {
              authenticationBloc.dispatch(LoggedOut());
            },
          ),
        ),
      ),
    );
  }
}
