import 'dart:async';
import 'package:appointmentproject/BLoC/SignUpBloc/bloc.dart';
import 'package:appointmentproject/BLoC/signUpBloc/bloc.dart';
import 'package:appointmentproject/model/client.dart';
import 'package:appointmentproject/model/service.dart';
import 'package:appointmentproject/repository/client_repository.dart';
import 'package:appointmentproject/repository/service_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './bloc.dart';

class UserRoleBloc extends Bloc<UserRoleEvent, UserRoleState> {
  Firestore _dbRef;

  @override
  UserRoleState get initialState => InitialUserRoleState();

  UserRoleBloc(){
    _dbRef = Firestore.instance;
  }

  @override
  Stream<UserRoleState> mapEventToState(
    UserRoleEvent event,
  ) async* {
    print("in check user role async");
    if(event is CheckUserRoleEvent){

      FirebaseUser user = await PersonRepository.defaultConstructor().getCurrentUser();
      print("in check user role event");
      print(user.email);

      if(await checkProfessionalRole(user)){
        print("check professional true");
        yield ProfessionalState(user: user);
      }
      else if(await checkClientRole(user)){
        print("check client true");
        yield ClientState(user: user,client: await getClientData(user.uid));
      }
      else{
        print("client details not filled state");

        yield ClientDetailsNotFilled(services: await getServicesList(null));
      }
    }


  }

  Future<List<Service>> getServicesList(String need) async{
    return await ServiceRepository.defaultConstructor().getServicesList(need);
  }

  Future<bool> checkProfessionalRole(FirebaseUser user) async {
    DocumentSnapshot data = await _dbRef.collection('professional').document(user.uid).get();
    return data.exists;

  }

  Future<bool> checkClientRole(FirebaseUser user) async {
    return ClientRepository.defaultConstructor().checkClientDetails(user.uid);
  }


  Future<Client> getClientData(String uid) async {
    return await ClientRepository.defaultConstructor().getClientData(uid);
  }



}
