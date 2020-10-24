




import 'package:appointmentproject/bloc/UserRoleBloc/bloc.dart';
import 'package:appointmentproject/model/client.dart';
import 'package:appointmentproject/model/professional.dart';
import 'package:appointmentproject/model/service.dart';
import 'package:appointmentproject/repository/client_repository.dart';
import 'package:appointmentproject/repository/professional_repository.dart';
import 'package:appointmentproject/repository/service_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserRoleBloc extends Bloc<UserRoleEvent, UserRoleState> {


  @override
  UserRoleState get initialState => InitialUserRoleState();


  @override
  Stream<UserRoleState> mapEventToState(
    UserRoleEvent event,
  ) async* {
    if(event is CheckUserRoleEvent){
      print("in check user role event");
      Professional professional;
      try{
         professional = await getProfessionalData(event.user);
      }catch(e){
        print(e);
      }


      if(professional != null){
        print("check professional true");
        yield ProfessionalState(professional: professional);
      }

      Client client = await getClientData(event.user);

      if(client != null){
        print("check client true");
        yield ClientState(user: event.user,client: client);
      }
      else{
        print("client details not filled state");
        yield ClientDetailsNotFilled(services: await getServicesList(null));
      }
    }


  }

  Future<List<Service>> getServicesList(DocumentReference need) async{
    return await ServiceRepository.defaultConstructor().getServicesList(need);
  }



  Future<Client> getClientData(FirebaseUser user) async {
    return await ClientRepository.defaultConstructor().getClientData(user);
  }

  Future<Professional> getProfessionalData(FirebaseUser user) async {
    return await ProfessionalRepository.defaultConstructor().getProfessionalData(user);
  }



}
