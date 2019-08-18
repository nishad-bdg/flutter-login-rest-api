import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_api/blocs/login/bloc.dart';
import 'package:login_api/services/repository.dart';

class LoginPage extends StatefulWidget {
  final Repository repository;
  LoginPage({this.repository});
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  LoginBloc _loginBloc;

  @override
  void initState() {
    super.initState();
    _loginBloc = LoginBloc(repository: widget.repository);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: BlocProvider(
        builder: (context) => _loginBloc,
        child: BlocBuilder(
          bloc: _loginBloc,
          builder: (context, state) {
            if (state is LoginInitial) {
              return buildLoginForm();
            }
            else if(state is LoginLoading){
              return Center(child: CircularProgressIndicator());
            }
            else{
              
              return Center(
                child: Text("Invalid username and password"),
              );
            }
          },
        ),
      ),
    );
  }

  Widget buildLoginForm() {
    return SingleChildScrollView(
      child: Container(
          margin: const EdgeInsets.all(15.0),
          height: MediaQuery.of(context).size.height,
          child: loginForm()),
    );
  }

  Widget loginForm() {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextFormField(
            controller: _usernameController,
            validator: (String value) {
              if (value.isEmpty) {
                return "please enter username";
              }
            },
            decoration: InputDecoration(
                hintText: "enter username", labelText: "username"),
          ),
          SizedBox(height: 20.0),
          TextFormField(
            controller: _passwordController,
            obscureText: true,
            validator: (String value) {
              if (value.isEmpty) {
                return "please enter password";
              }
            },
            decoration: InputDecoration(
                hintText: "please enter password", labelText: "password"),
          ),
          SizedBox(height: 20.0),
          ButtonTheme(
            minWidth: double.infinity,
            child: RaisedButton(
              color: Colors.deepPurple,
              child: Text(
                "Login",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                print("Login pressed");
               _loginBloc.dispatch(
                    LoginButtonPressedEvent(
                        username: _usernameController.text,
                        password: _passwordController.text));
              },
            ),
          )
        ],
      ),
    );
  }
}
