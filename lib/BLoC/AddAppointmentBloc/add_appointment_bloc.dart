import 'dart:async';
import 'package:appointmentproject/repository/sub_services_repository.dart';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class AddAppointmentBloc extends Bloc<AddAppointmentEvent, AddAppointmentState> {

  SubServiceRepository subServiceRepository;
  
  @override
  AddAppointmentState get initialState => InitialAddAppointmentState();

  @override
  Stream<AddAppointmentState> mapEventToState(
    AddAppointmentEvent event,
  ) async* {
    if(event is TapOnServiceEvent){
      print(event.serviceID);
      subServiceRepository = new SubServiceRepository(serviceID: event.serviceID);
      yield TapOnServiceState(subServicesList: await subServiceRepository.getSubServicesList());

    }
  }


/*
  Future<void> serviceList(String serviceID) async{
    DatabaseReference reference =
    FirebaseDatabase.instance.reference().child("sub_services").orderByChild("serviceid");
    await reference.equalTo(serviceID).once().then((DataSnapshot snapshot) {
      var KEYS = snapshot.value.keys;
      var DATA = snapshot.value;
      for(var individualKey in KEYS){
        SubServices service = new SubServices(
          key: individualKey,
          name: DATA[individualKey]['name'],
          link: DATA[individualKey]['link'],
        );
        servicesList.add(service);
      }
    });


  }*/
  
  
  
}
