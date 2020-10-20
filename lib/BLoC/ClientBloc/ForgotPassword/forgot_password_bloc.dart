import 'dart:async';


import 'package:appointmentproject/repository/person_repository.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'forgot_password_event.dart';
part 'forgot_password_state.dart';

class ForgotPasswordBloc extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {

  @override
  ForgotPasswordState get initialState => ForgotPasswordInitial();


  @override
  Stream<ForgotPasswordState> mapEventToState(
    ForgotPasswordEvent event,
  ) async* {
    if(event is SendPasswordResetLink){
      try{
        await PersonRepository.defaultConstructor().sendPasswordResetMail(event.email);
        yield ForgotPasswordEmailSent();
      }catch(e){
        String errorMessage = "";
        if(e is PlatformException){
          if(e.code == "ERROR_INVALID_EMAIL"){
            errorMessage = "Your email is invalid";
          }
          else if(e.code == "ERROR_USER_NOT_FOUND"){
            errorMessage = "you are not registered with us";
          }
          else{
            errorMessage = "undefined error or network problem";
          }
          yield ForgotPasswordEmailNotSent(message: errorMessage);
        }
      }
    }
  }


}
