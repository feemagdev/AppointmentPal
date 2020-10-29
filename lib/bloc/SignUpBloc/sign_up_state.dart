
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

abstract class SignUpState{}

class SignUpInitialState extends SignUpState{}

class SignUpLoadingState extends SignUpState{}

class SignUpSuccessfulState extends SignUpState{
  final User user;
  SignUpSuccessfulState({@required this.user});

}

class SignUpFailureState extends SignUpState{
  final String message;
  SignUpFailureState({@required this.message});
}


class AlreadyHaveAnAccountState extends SignUpState {}



