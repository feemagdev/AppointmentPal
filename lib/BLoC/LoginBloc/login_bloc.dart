

import 'package:appointmentproject/BLoC/LoginBloc/login_event.dart';
import 'package:appointmentproject/BLoC/LoginBloc/login_state.dart';
import 'package:appointmentproject/model/service.dart';
import 'package:appointmentproject/repository/client_repository.dart';
import 'package:appointmentproject/repository/person_repository.dart';
import 'package:appointmentproject/repository/service_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class LoginBloc extends Bloc<LoginEvent,LoginState>{

  Firestore _dbRef;
  FirebaseUser user;
  LoginBloc(){
    _dbRef = Firestore.instance;
  }

  @override
  // TODO: implement initialState
  LoginState get initialState => LoginInitialState();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async*{
    if(event is LoginButtonPressedEvent){
          try{
            user = await PersonRepository.defaultConstructor().signInUser(event.email, event.password);
            if(user.uid.isNotEmpty){
              if(await checkProfessionalRole(user)){
                print("check professional true");
                print(user.email);
                yield ProfessionalLoginSuccessState(user: user);
              }
              else if(await checkClientRole(user)){
                print("check client true");
                yield ClientLoginSuccessState(user: user);
              }
              else{
                print("sign in client not filled state");
                yield ClientDetailsNotFilledSignIn(services: await getServicesList(),user: user);
              }
  }

          }catch(e){
            yield LoginFailureState(message: e.toString());
          }
    }
  }



  Future<List<Service>> getServicesList() async{
    return await ServiceRepository.defaultConstructor().getServicesList();
  }


  Future<bool> checkProfessionalRole(FirebaseUser user) async {
    DocumentSnapshot data = await _dbRef.collection('professional').document(user.uid).get();
    return data.exists;

  }

  Future<bool> checkClientRole(FirebaseUser user) async {
    return ClientRepository.defaultConstructor().checkClientDetails(user.uid);
  }








}