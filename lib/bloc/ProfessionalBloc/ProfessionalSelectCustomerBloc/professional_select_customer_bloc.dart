import 'dart:async';

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

  ProfessionalSelectCustomerBloc(
      {@required this.professional,
      @required this.appointmentStartTime,
      @required this.appointmentEndTime});

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
    }else if(event is MoveBackToSelectDateTimeScreenEvent){
      yield MoveBackToSelectDateTimeScreenState(professional: event.professional);
    }
  }

  @override
  ProfessionalSelectCustomerState get initialState =>
      ProfessionalSelectCustomerInitial(
          professional: professional,
          appointmentStartTime: appointmentStartTime,
          appointmentEndTime: appointmentEndTime);
}
