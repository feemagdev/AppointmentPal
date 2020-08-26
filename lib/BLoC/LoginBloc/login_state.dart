


import 'package:appointmentproject/model/client.dart';
import 'package:appointmentproject/model/service.dart';
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
  final Client client;
  ClientLoginSuccessState({@required this.user, @required this.client});
}





class LoginFailureState extends LoginState{
  final String message;
  LoginFailureState({@required this.message});

}


class ClientDetailsNotFilledSignIn extends LoginState{
  final List<Service> services;
  final FirebaseUser user;
  ClientDetailsNotFilledSignIn({@required this.services, @required this.user});
}

class ForgotPasswordState extends LoginState{}
class DoNotHaveAnAccountState extends LoginState{}