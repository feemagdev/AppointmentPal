import 'package:appointmentproject/model/service.dart';
import 'package:appointmentproject/repository/service_repository.dart';
import 'package:flutter/services.dart';

import './bloc.dart';

class SignUpBloc extends Bloc<SignUpEvent,SignUpState>{
  @override
  // TODO: implement initialState
  SignUpState get initialState => SignUpInitialState();

  @override
  Stream<SignUpState> mapEventToState(SignUpEvent event) async*{
    if(event is SignUpButtonPressedEvent){
      try{
        yield SignUpLoadingState();
        print(event.email);
        try{
          PersonRepository personRepository = new PersonRepository(email: event.email, password: event.password);
          var user = await personRepository.registerUser();
          PersonRepository.defaultConstructor().sendVerificationEmail(user);
          yield SignUpSuccessfulState(user: user);
        }catch (e) {
          String errorMessage = "";
          if (e is PlatformException) {
            if (e.code == "ERROR_INVALID_EMAIL") {
              errorMessage = "Your email is invalid";
            } else if (e.code == "ERROR_USER_NOT_FOUND") {
              errorMessage = "you are not registered with us";
            } else if (e.code == "ERROR_WRONG_PASSWORD") {
              errorMessage = "your password is wrong";
            } else if(e.code == "ERROR_EMAIL_ALREADY_IN_USE"){
              errorMessage = "this email is already in use";
            }else {
              errorMessage = "undefined error or network problem";
              yield SignUpFailureState(message: e.toString());
            }
            yield SignUpFailureState(message: errorMessage);
          }
        }

      }catch(e){
        yield SignUpFailureState(message:e.toString());
      }
    }
  }

  Future<List<Service>> getServicesList(){
    return ServiceRepository.defaultConstructor().getServicesList(null);
  }

}