import 'dart:async';

import 'package:appointmentproject/model/appointment.dart';
import 'package:appointmentproject/model/professional.dart';
import 'package:appointmentproject/repository/appointment_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'professional_edit_appointment_event.dart';
part 'professional_edit_appointment_state.dart';

class ProfessionalEditAppointmentBloc extends Bloc<ProfessionalEditAppointmentEvent, ProfessionalEditAppointmentState> {
  final Professional professional;
  ProfessionalEditAppointmentBloc({@required this.professional});

  @override
  Stream<ProfessionalEditAppointmentState> mapEventToState(
    ProfessionalEditAppointmentEvent event,
  ) async* {
    if(event is ProfessionalShowSelectedDayAppointmentsEvent){
      List<Appointment> appointments = List();
      DateTime dateTime = event.dateTime;
      if(dateTime == null){
        dateTime = DateTime.now();
      }
      appointments = await AppointmentRepository.defaultConstructor().getProfessionalSelectedDayAppointments(event.professional.getProfessionalID(),Timestamp.fromDate(dateTime));
      yield ProfessionalShowSelectedDayAppointmentsState(professional: event.professional,appointments: appointments);
    }
    if(event is ProfessionalEditAppointmentSelectedEvent) {
      yield ProfessionalAppointmentIsSelectedState(appointment: event.appointment,professional: event.professional);
    }
  }

  @override
  ProfessionalEditAppointmentState get initialState => ProfessionalEditAppointmentInitial(professional: professional);
}
