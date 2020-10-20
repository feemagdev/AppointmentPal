import 'dart:async';

import 'package:appointmentproject/model/customer.dart';
import 'package:appointmentproject/model/professional.dart';
import 'package:appointmentproject/model/schedule.dart';
import 'package:appointmentproject/repository/customer_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'professional_select_customer_event.dart';

part 'professional_select_customer_state.dart';

class ProfessionalSelectCustomerBloc extends Bloc<
    ProfessionalSelectCustomerEvent, ProfessionalSelectCustomerState> {
  final Professional professional;
  final DateTime selectedDateTime;
  final Schedule schedule;

  ProfessionalSelectCustomerBloc(
      {@required this.professional,
      @required this.selectedDateTime,
      @required this.schedule});

  @override
  Stream<ProfessionalSelectCustomerState> mapEventToState(
    ProfessionalSelectCustomerEvent event,
  ) async* {
    if (event is ProfessionalSelectCustomerShowAllCustomerEvent) {
      List<Customer> customers = new List();
      customers = await CustomerRepository.defaultConstructor()
          .getAllCustomersOfProfessional(
              event.professional.getProfessionalID().documentID);

      yield ProfessionalSelectCustomerShowAllCustomerState(
          professional: event.professional,
          customer: customers,
          selectedDateTime: event.selectedDateTime,
          schedule: event.schedule);
    } else if (event is AddCustomerButtonPressedEvent) {
      yield AddCustomerButtonPressedState(
          professional: event.professional,
          selectedDateTime: event.selectedDateTime,
          schedule: event.schedule);
    } else if (event is CustomerIsSelectedEvent) {
      yield CustomerIsSelectedState(
          professional: event.professional,
          customer: event.customer,
          schedule: event.schedule,
          appointmentTime: event.appointmentTime);
    }else if(event is MoveBackToSelectDateTimeScreenEvent){
      yield MoveBackToSelectDateTimeScreenState(professional: event.professional);
    }
  }

  @override
  ProfessionalSelectCustomerState get initialState =>
      ProfessionalSelectCustomerInitial(
          professional: professional,
          selectedDateTime: selectedDateTime,
          schedule: schedule);
}
