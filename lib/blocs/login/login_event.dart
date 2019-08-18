import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class LoginEvent extends Equatable {
  LoginEvent([List props = const <dynamic>[]]) : super(props);
}

class LoginButtonPressedEvent extends LoginEvent {
  final String username;
  final String password;
  LoginButtonPressedEvent({@required this.username, @required this.password})
      : super([username, password]);
}
