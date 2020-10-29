


import 'package:appointmentproject/model/professional.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

abstract class LoginState  {}

class LoginInitialState extends LoginState{
  LoginInitialState();

}

class LoginLoadingState extends LoginState{
  LoginLoadingState(User user);

}


class ProfessionalLoginSuccessState extends LoginState{

  final Professional professional;

  ProfessionalLoginSuccessState({@required this.professional});


}






class LoginFailureState extends LoginState{
  final String message;
  LoginFailureState({@required this.message});

}




class ForgotPasswordState extends LoginState{}