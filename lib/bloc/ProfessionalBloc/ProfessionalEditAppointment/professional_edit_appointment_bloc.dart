import 'dart:async';

import 'package:appointmentproject/model/appointment.dart';
import 'package:appointmentproject/model/customer.dart';
import 'package:appointmentproject/model/manager.dart';
import 'package:appointmentproject/model/professional.dart';
import 'package:appointmentproject/repository/appointment_repository.dart';
import 'package:appointmentproject/repository/customer_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'professional_edit_appointment_event.dart';
part 'professional_edit_appointment_state.dart';

class ProfessionalEditAppointmentBloc extends Bloc<
    ProfessionalEditAppointmentEvent, ProfessionalEditAppointmentState> {
  final Professional professional;
  final Manager manager;

  ProfessionalEditAppointmentBloc({@required this.professional, this.manager});

  @override
  Stream<ProfessionalEditAppointmentState> mapEventToState(
    ProfessionalEditAppointmentEvent event,
  ) async* {
    if (event is ProfessionalShowSelectedDayAppointmentsEvent) {
      yield ProfessionalEditAppointmentLoadingState();
      List<Appointment> appointments = List();
      List<Customer> customers = List();
      DateTime dateTime = event.dateTime;
      if (dateTime == null) {
        dateTime = DateTime.now();
      }
      appointments = await AppointmentRepository.defaultConstructor()
          .getProfessionalSelectedDayAppointments(
          professional.getProfessionalID(),
          Timestamp.fromDate(dateTime));
      if (appointments.isNotEmpty || appointments.length != 0) {
        await Future.forEach(appointments, (element) async {
          customers.add(await CustomerRepository.defaultConstructor()
              .getCustomer(
                  element.getProfessionalID(), element.getCustomerID()));
        });
      }
      yield ProfessionalShowSelectedDayAppointmentsState(
          appointments: appointments,
          customers: customers);
    } else if (event is ProfessionalEditAppointmentSelectedEvent) {
      yield ProfessionalAppointmentIsSelectedState(
          appointment: event.appointment,
          customer: event.customer);
    } else if (event is MoveToDashboardScreenFromEditAppointmentEvent) {
      yield MoveToDashboardScreenFromEditAppointmentState();
    }
  }

  @override
  ProfessionalEditAppointmentState get initialState =>
      ProfessionalEditAppointmentInitial();
}
