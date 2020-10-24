import 'package:meta/meta.dart';

abstract class LoginEvent{}

class LoginButtonPressedEvent extends LoginEvent{

  final String email,password;
  LoginButtonPressedEvent({@required this.email,@required this.password});
}

class ForgotPasswordButtonPressedEvent extends LoginEvent{}


class DoNotHaveAnAccountEvent extends LoginEvent {}

