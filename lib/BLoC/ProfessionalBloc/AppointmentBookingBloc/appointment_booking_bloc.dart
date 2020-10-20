import 'dart:async';

import 'package:appointmentproject/model/customer.dart';
import 'package:appointmentproject/model/professional.dart';
import 'package:appointmentproject/model/schedule.dart';
import 'package:appointmentproject/repository/appointment_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'appointment_booking_event.dart';

part 'appointment_booking_state.dart';

class AppointmentBookingBloc
    extends Bloc<AppointmentBookingEvent, AppointmentBookingState> {
  final Professional professional;
  final Customer customer;
  final DateTime selectedDateTime;
  final Schedule schedule;

  AppointmentBookingBloc(
      {@required this.professional, @required this.customer, @required this.selectedDateTime, @required this.schedule});

  @override
  Stream<AppointmentBookingState> mapEventToState(
      AppointmentBookingEvent event,) async* {
    if(event is AddAppointmentButtonPressedEvent){
      AppointmentRepository.defaultConstructor().professionalMakeAppointment(
          event.professional.getProfessionalID(),
          event.customer.getCustomerID(),
          Timestamp.fromDate(event.appointmentTime),
          'booked');
      yield AppointmentBookedSuccessfully(professional: event.professional);
    }
  }


  @override
  AppointmentBookingState get initialState =>
      AppointmentBookingInitial(professional: professional,
          customer: customer,
          startDateTime: selectedDateTime,
          schedule: schedule);
}
