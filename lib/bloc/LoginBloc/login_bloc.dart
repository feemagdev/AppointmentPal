

import 'package:appointmentproject/bloc/LoginBloc/login_event.dart';
import 'package:appointmentproject/bloc/LoginBloc/login_state.dart';
import 'package:appointmentproject/model/professional.dart';
import 'package:appointmentproject/repository/person_repository.dart';
import 'package:appointmentproject/repository/professional_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {

  User user;

  @override
  LoginState get initialState => LoginInitialState();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginButtonPressedEvent) {
      bool professionalCheck = false;
      try {
        user = await PersonRepository.defaultConstructor()
            .signInUser(event.email, event.password);
        print("return from professional repository");
        if (user.uid.isNotEmpty) {
          Professional professional = await checkProfessionalRole(user);
          if (professional != null ) {
            professionalCheck = true;
            yield ProfessionalLoginSuccessState(professional: professional);
          }
        }
      } catch (e) {
        String errorMessage = "";
        if (e is FirebaseAuthException) {
          if (e.code == "user-not-found") {
            errorMessage = "you are not registered with us";
          } else if (e.code == "wrong-password") {
            errorMessage = "your password is wrong";
          }else if (e.code == "too-many-requests") {
            errorMessage = "Too many requests please try again later";
          } else {
            errorMessage = "undefined error or network problem";
            yield LoginFailureState(message: e.toString());
          }
          yield LoginFailureState(message: errorMessage);
        }
      }
    } else if (event is ForgotPasswordButtonPressedEvent) {
      yield ForgotPasswordState();
    }
  }



  Future<Professional> checkProfessionalRole(User user) async {
    return await ProfessionalRepository.defaultConstructor().getProfessionalData(user);
  }

}
