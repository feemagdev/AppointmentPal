part of 'signup_bloc.dart';

abstract class SignupState {}

class SignupInitial extends SignupState {}

class SignUpLoadingState extends SignupState {}

class SignUpSuccessfulState extends SignupState {
  final User user;
  SignUpSuccessfulState({@required this.user});
}

class SignUpFailureState extends SignupState {
  final String message;
  SignUpFailureState({@required this.message});
}

class AlreadyHaveAnAccountState extends SignupState {}
