
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

abstract class AuthState {}

class AuthInitialState extends AuthState{}

class AuthenticatedState extends AuthState{

  final FirebaseUser user;
  AuthenticatedState({@required this.user});

}

class UnAuthenticatedState extends AuthState{}