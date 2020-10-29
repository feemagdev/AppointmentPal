import 'dart:async';

import 'package:appointmentproject/model/appointment.dart';
import 'package:appointmentproject/model/customer.dart';
import 'package:appointmentproject/model/professional.dart';
import 'package:appointmentproject/repository/customer_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'professional_select_customer_event.dart';

part 'professional_select_customer_state.dart';

class ProfessionalSelectCustomerBloc extends Bloc<
    ProfessionalSelectCustomerEvent, ProfessionalSelectCustomerState> {
  final Professional professional;
  final DateTime appointmentStartTime;
  final DateTime appointmentEndTime;
  final Appointment appointment;
  final Customer customer;

  ProfessionalSelectCustomerBloc(
      {@required this.professional,
      @required this.appointmentStartTime,
      @required this.appointmentEndTime,
      this.appointment,
      this.customer});

  @override
  Stream<ProfessionalSelectCustomerState> mapEventToState(
    ProfessionalSelectCustomerEvent event,
  ) async* {
    if (event is ProfessionalSelectCustomerShowAllCustomerEvent) {
      List<Customer> customers = new List();
      customers = await CustomerRepository.defaultConstructor()
          .getAllCustomersOfProfessional(
              event.professional.getProfessionalID().id);

      yield ProfessionalSelectCustomerShowAllCustomerState(
          professional: event.professional,
          customers: customers,
          appointmentStartTime: event.appointmentStartTime,
          appointmentEndTime: event.appointmentEndTime);
    } else if (event is AddCustomerButtonPressedEvent) {
      yield AddCustomerButtonPressedState(
          professional: event.professional,
          appointmentStartTime: event.appointmentStartTime,
          appointmentEndTime: event.appointmentEndTime);
    } else if (event is CustomerIsSelectedEvent) {
      yield CustomerIsSelectedState(
          professional: event.professional,
          customer: event.customer,
          appointmentStartTime: event.appointmentStartTime,
          appointmentEndTime: event.appointmentEndTime);
    } else if (event is MoveBackToSelectDateTimeScreenEvent) {
      yield MoveBackToSelectDateTimeScreenState(
          professional: event.professional);
    }else if(event is MoveBackToUpdateAppointmentScreenEvent){
      yield CustomerIsSelectedState(professional: professional, appointmentStartTime: appointmentStartTime, appointmentEndTime: appointmentEndTime, customer: customer,appointment: appointment);
    }
  }

  @override
  ProfessionalSelectCustomerState get initialState =>
      ProfessionalSelectCustomerInitial(
          professional: professional,
          appointmentStartTime: appointmentStartTime,
          appointmentEndTime: appointmentEndTime);
}
