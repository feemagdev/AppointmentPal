import 'dart:async';

import 'package:appointmentproject/model/appointment.dart';
import 'package:appointmentproject/model/customer.dart';
import 'package:appointmentproject/model/manager.dart';
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
  final Manager manager;

  ProfessionalSelectCustomerBloc(
      {@required this.professional,
      @required this.appointmentStartTime,
      @required this.appointmentEndTime,
      this.appointment,
      this.customer,
      this.manager});

  @override
  Stream<ProfessionalSelectCustomerState> mapEventToState(
    ProfessionalSelectCustomerEvent event,
  ) async* {
    if (event is ProfessionalSelectCustomerShowAllCustomerEvent) {
      List<Customer> customers = new List();
      customers = await CustomerRepository.defaultConstructor()
          .getAllCustomersOfProfessional(professional.getProfessionalID());

      yield ProfessionalSelectCustomerShowAllCustomerState(
        customers: customers,
      );
    } else if (event is AddCustomerButtonPressedEvent) {
      yield AddCustomerButtonPressedState();
    } else if (event is CustomerIsSelectedEvent) {
      yield CustomerIsSelectedState(customer: event.customer);
    } else if (event is MoveBackToSelectDateTimeScreenEvent) {
      yield MoveBackToSelectDateTimeScreenState(
          professional: event.professional);
    } else if (event is MoveBackToUpdateAppointmentScreenEvent) {
      yield CustomerIsSelectedState(customer: customer);
    }
  }

  @override
  ProfessionalSelectCustomerState get initialState =>
      ProfessionalSelectCustomerInitial();
}
