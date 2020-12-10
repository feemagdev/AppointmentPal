import 'package:appointmentproject/model/manager.dart';
import 'package:appointmentproject/model/professional.dart';
import 'package:meta/meta.dart';

abstract class LoginState {}

class LoginInitialState extends LoginState {
  LoginInitialState();
}

class LoginLoadingState extends LoginState {}

class ProfessionalLoginSuccessState extends LoginState {
  final Professional professional;

  ProfessionalLoginSuccessState({@required this.professional});
}

class ManagerLoginSuccessState extends LoginState {
  final Manager manager;

  ManagerLoginSuccessState({@required this.manager});
}

class LoginFailureState extends LoginState {
  final String message;

  LoginFailureState({@required this.message});
}

class ForgotPasswordState extends LoginState {}

class MoveToSignUpScreenState extends LoginState {}

class UserDetailNotFilledState extends LoginState {
  final String uid;
  UserDetailNotFilledState({@required this.uid});
}
