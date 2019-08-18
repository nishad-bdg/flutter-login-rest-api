import 'package:flutter/material.dart';
import 'package:login_api/pages/login_page.dart';
import 'package:login_api/services/repository.dart';

void main(){
  final Repository repository = Repository();
  runApp(MyApp(repository:repository));
}

class MyApp extends StatelessWidget {
  final Repository repository;
  MyApp({this.repository});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Simple Auth App',
      theme: ThemeData(
        primaryColor: Colors.deepPurple
      ),
      home: LoginPage(repository:repository),
    );
  }
}