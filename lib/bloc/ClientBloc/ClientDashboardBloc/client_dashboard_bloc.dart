import 'dart:async';


import 'package:appointmentproject/bloc/ClientBloc/ClientDashboardBloc/bloc.dart';
import 'package:appointmentproject/repository/service_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



class ClientDashboardBloc extends Bloc<ClientDashboardEvent, ClientDashboardState> {

  @override
  ClientDashboardState get initialState => InitialClientDashboardState();

  @override
  Stream<ClientDashboardState> mapEventToState(
    ClientDashboardEvent event,
  ) async* {

    if(event is SearchBarOnTapEvent){
      yield MoveToSearchScreenState();
    }
    if(event is AddAppointmentEvent){
      yield AddAppointmentScreenState(serviceList: await ServiceRepository.defaultConstructor().getServicesList(event.client.getNeed()));
    }
    if(event is EditAppointmentEvent){
      yield EditAppointmentScreenState(client: event.client);
    }
  }



}
