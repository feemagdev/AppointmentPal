
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

abstract class LoginState  {}

class LoginInitialState extends LoginState{
  LoginInitialState();

}

class LoginLoadingState extends LoginState{
  LoginLoadingState(FirebaseUser user);

}


class ProfessionalLoginSuccessState extends LoginState{

  final FirebaseUser user;

  ProfessionalLoginSuccessState({@required this.user});


}

class ClientLoginSuccessState extends LoginState{

  final FirebaseUser user;

  ClientLoginSuccessState({@required this.user});
}





class LoginFailureState extends LoginState{
  final String message;
  LoginFailureState({@required this.message});

}