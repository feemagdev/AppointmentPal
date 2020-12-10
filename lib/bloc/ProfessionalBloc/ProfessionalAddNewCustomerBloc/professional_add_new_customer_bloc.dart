import 'dart:async';

import 'package:appointmentproject/model/appointment.dart';
import 'package:appointmentproject/model/customer.dart';
import 'package:appointmentproject/model/manager.dart';
import 'package:appointmentproject/model/professional.dart';
import 'package:appointmentproject/repository/customer_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'professional_add_new_customer_event.dart';

part 'professional_add_new_customer_state.dart';

class ProfessionalAddNewCustomerBloc extends Bloc<
    ProfessionalAddNewCustomerEvent, ProfessionalAddNewCustomerState> {
  final Professional professional;
  final DateTime appointmentStartTime;
  final DateTime appointmentEndTime;
  final Appointment appointment;
  final Customer customer;
  final Manager manager;

  ProfessionalAddNewCustomerBloc(
      {@required this.professional,
      this.appointmentStartTime,
      this.appointmentEndTime,
      this.appointment,
      this.customer,
      this.manager});

  @override
  Stream<ProfessionalAddNewCustomerState> mapEventToState(
    ProfessionalAddNewCustomerEvent event,
  ) async* {
    if (event is AddNewCustomerButtonPressedEvent) {
      yield AddNewCustomerLoadingState();
      Customer customer = await CustomerRepository.defaultConstructor()
          .addCustomer(event.professional.getProfessionalID(), event.name,
              event.phone, event.address, event.city, event.country);
      if (customer != null) {
        yield CustomerAddedSuccessfullyState(customer: customer);
      }
    } else if (event is CheckPhoneEvent) {
      yield AddNewCustomerLoadingState();
      bool customerCheck = await CustomerRepository.defaultConstructor()
          .checkCustomerExist(
              event.phone, event.professional.getProfessionalID());
      if (customerCheck) {
        print("customer check true");
        yield CustomerAlreadyExistState(professional: event.professional);
      } else {
        yield CustomerCanBeAdded(professional: event.professional);
      }
    }
  }

  @override
  ProfessionalAddNewCustomerState get initialState =>
      ProfessionalAddNewCustomerInitial(
          professional: professional,
          appointmentStartTime: appointmentStartTime,
          appointmentEndTime: appointmentEndTime);
}
