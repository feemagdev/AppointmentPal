import 'file:///C:/Users/faheem/AndroidStudioProjects/appointment_project/lib/BLoC/LoginBloc/login_event.dart';
import 'file:///C:/Users/faheem/AndroidStudioProjects/appointment_project/lib/BLoC/LoginBloc/login_state.dart';
import 'package:appointmentproject/BLoC/ProfessionalBloc/bloc.dart';
import 'package:appointmentproject/model/client.dart';
import 'package:appointmentproject/model/professional.dart';
import 'package:appointmentproject/model/service.dart';
import 'package:appointmentproject/repository/client_repository.dart';
import 'package:appointmentproject/repository/person_repository.dart';
import 'package:appointmentproject/repository/service_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  Firestore _dbRef;
  FirebaseUser user;

  LoginBloc() {
    _dbRef = Firestore.instance;
  }

  @override
  // TODO: implement initialState
  LoginState get initialState => LoginInitialState();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginButtonPressedEvent) {
      bool professionalCheck = false;
      try {
        user = await PersonRepository.defaultConstructor()
            .signInUser(event.email, event.password);
        if (user.uid.isNotEmpty) {
          Professional professional = await checkProfessionalRole(user);
          if (professional != null ) {
            professionalCheck = true;
            print("check professional true");
            yield ProfessionalLoginSuccessState(professional: professional);
          }
          if(professionalCheck == false){
            Client client  = await getClientData(user);
            if (client != null) {
              print("check client true");
              try{
                yield ClientLoginSuccessState(
                    user: user, client: client);
              }catch(e){
                print(e);
              }
            } else {
              print("sign in client not filled state");
              yield ClientDetailsNotFilledSignIn(
                  services: await getServicesList(), user: user);
            }
          }
        }
      } catch (e) {
        String errorMessage = "";
        if (e is PlatformException) {
          if (e.code == "ERROR_INVALID_EMAIL") {
            errorMessage = "Your email is invalid";
          } else if (e.code == "ERROR_USER_NOT_FOUND") {
            errorMessage = "you are not registered with us";
          } else if (e.code == "ERROR_WRONG_PASSWORD") {
            errorMessage = "your password is wrong";
          } else {
            errorMessage = "undefined error or network problem";
            yield LoginFailureState(message: e.toString());
          }
          yield LoginFailureState(message: errorMessage);
        }
      }
    } else if (event is ForgotPasswordButtonPressedEvent) {
      print("forgot passord evemt");
      yield ForgotPasswordState();
    } else if(event is DoNotHaveAnAccountEvent){
      yield DoNotHaveAnAccountState();
    }
  }

  Future<List<Service>> getServicesList() async {
    return await ServiceRepository.defaultConstructor().getServicesList(null);
  }

  Future<Client> getClientData(FirebaseUser user) async {
    return await ClientRepository.defaultConstructor().getClientData(user);
  }

  Future<Professional> checkProfessionalRole(FirebaseUser user) async {
    return await ProfessionalRepository.defaultConstructor().getProfessionalData(user);
  }

}
