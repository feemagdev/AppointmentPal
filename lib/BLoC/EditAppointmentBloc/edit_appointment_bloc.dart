import 'dart:async';

import 'package:appointmentproject/model/appointment.dart';
import 'package:appointmentproject/model/client.dart';
import 'package:appointmentproject/model/professional.dart';
import 'package:appointmentproject/repository/appointment_repository.dart';
import 'package:appointmentproject/repository/client_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'edit_appointment_event.dart';
part 'edit_appointment_state.dart';

class EditAppointmentBloc extends Bloc<EditAppointmentEvent, EditAppointmentState> {
  final Client client;
  EditAppointmentBloc({@required this.client});

  @override
  Stream<EditAppointmentState> mapEventToState(
    EditAppointmentEvent event,
  ) async* {

    if(event is ShowSelectedDayAppointmentsEvent){
      List<Appointment> appointments = List();
      List<Professional> professionals = List();
      DateTime dateTime = event.dateTime;
      if(dateTime == null){
        dateTime = DateTime.now();
      }
      DocumentReference clientID = ClientRepository.defaultConstructor().getClientReference(event.client.getFirebaseUser().uid);
      appointments = await AppointmentRepository.defaultConstructor().getClientSelectedDayAppointments(clientID,Timestamp.fromDate(dateTime));
      yield ShowSelectedDayAppointmentsState(client: event.client,appointments: appointments);
    }

  }

  @override
  EditAppointmentState get initialState => EditAppointmentInitial(client: client);
}
