import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

abstract class SignUpState extends Equatable{}

class SignUpInitialState extends SignUpState{
  @override
  // TODO: implement props
  List<Object> get props => null;
}

class SignUpLoadingState extends SignUpState{
  @override
  // TODO: implement props
  List<Object> get props => null;
}

class SignUpSuccessfulState extends SignUpState{
  final FirebaseUser user;

  SignUpSuccessfulState({@required this.user});
  @override
  // TODO: implement props
  List<Object> get props => null;
}

class SignUpFailureState extends SignUpState{
  final String message;
  SignUpFailureState({@required this.message});

  @override
  // TODO: implement props
  List<Object> get props => null;

}