import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

abstract class LoginState extends Equatable{}

class LoginInitialState extends LoginState{
  LoginInitialState();

  @override
  // TODO: implement props
  List<Object> get props => null;
}

class LoginLoadingState extends LoginState{
  LoginLoadingState(FirebaseUser user);

  @override
  // TODO: implement props
  List<Object> get props => null;
}


// ignore: must_be_immutable
class ProfessionalLoginSuccessState extends LoginState{

  final FirebaseUser user;

  ProfessionalLoginSuccessState({@required this.user});

  @override
  // TODO: implement props
  List<Object> get props => null;

  FirebaseUser get getUser => user;
}

// ignore: must_be_immutable
class ClientLoginSuccessState extends LoginState{

  final FirebaseUser user;

  ClientLoginSuccessState({@required this.user});

  @override
  // TODO: implement props
  List<Object> get props => null;
  FirebaseUser get getUser => user;
}




// ignore: must_be_immutable
class LoginFailureState extends LoginState{
  String message;
  LoginFailureState({@required this.message});
  @override
  // TODO: implement props
  List<Object> get props => null;
}