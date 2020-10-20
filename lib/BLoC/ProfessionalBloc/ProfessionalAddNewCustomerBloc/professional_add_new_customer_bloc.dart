import 'dart:async';

import 'package:appointmentproject/model/customer.dart';
import 'package:appointmentproject/model/professional.dart';
import 'package:appointmentproject/model/schedule.dart';
import 'package:appointmentproject/repository/customer_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'professional_add_new_customer_event.dart';

part 'professional_add_new_customer_state.dart';

class ProfessionalAddNewCustomerBloc extends Bloc<
    ProfessionalAddNewCustomerEvent, ProfessionalAddNewCustomerState> {
  final Professional professional;
  final DateTime selectedDateTime;
  final Schedule schedule;

  ProfessionalAddNewCustomerBloc(
      {@required this.professional,this.selectedDateTime,this.schedule});

  @override
  Stream<ProfessionalAddNewCustomerState> mapEventToState(
    ProfessionalAddNewCustomerEvent event,
  ) async* {
    if (event is AddNewCustomerButtonPressedEvent) {
      Customer customer = await CustomerRepository.defaultConstructor()
          .addCustomer(event.professional.getProfessionalID().documentID,
              event.name, event.phone);

      if(customer != null){
        yield CustomerAddedSuccessfullyState(professional: professional,selectedDateTime: event.selectedDateTime,customer: customer,schedule: event.schedule);
      }

    }else if(event is MoveBackToSelectCustomerScreenEvent){
      yield MoveBackToSelectCustomerScreenState(professional: event.professional,schedule: event.schedule,appointmentTime: event.appointmentTime);
    }
  }

  @override
  ProfessionalAddNewCustomerState get initialState =>
      ProfessionalAddNewCustomerInitial(
          professional: professional, selectedDateTime: selectedDateTime,schedule: schedule);
}
