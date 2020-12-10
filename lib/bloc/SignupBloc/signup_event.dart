part of 'signup_bloc.dart';

abstract class SignupEvent {}

class SignUpButtonEvent extends SignupEvent {
  final String email;
  final String password;
  SignUpButtonEvent({@required this.email, @required this.password});
}

class AlreadyHaveAnAccountEvent extends SignupEvent {}
