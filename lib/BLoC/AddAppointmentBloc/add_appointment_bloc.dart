import 'dart:async';
import 'package:appointmentproject/repository/sub_services_repository.dart';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class AddAppointmentBloc
    extends Bloc<AddAppointmentEvent, AddAppointmentState> {
  @override
  AddAppointmentState get initialState => InitialAddAppointmentState();

  @override
  Stream<AddAppointmentState> mapEventToState(
    AddAppointmentEvent event,
  ) async* {
    if (event is TapOnServiceEvent) {
      print(event.serviceID);
      yield TapOnServiceState(
          subServicesList: await SubServiceRepository.defaultConstructor()
              .getSubServicesList(event.serviceID));
    }
  }


}
