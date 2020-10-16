import 'dart:async';

import 'package:appointmentproject/model/customer.dart';
import 'package:appointmentproject/model/professional.dart';
import 'package:appointmentproject/repository/customer_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'professional_select_customer_event.dart';
part 'professional_select_customer_state.dart';

class ProfessionalSelectCustomerBloc extends Bloc<ProfessionalSelectCustomerEvent, ProfessionalSelectCustomerState> {
  final Professional professional;
  final DateTime selectedDateTime;
  ProfessionalSelectCustomerBloc({@required this.professional,@required this.selectedDateTime});
  @override
  Stream<ProfessionalSelectCustomerState> mapEventToState(
    ProfessionalSelectCustomerEvent event,
  ) async* {
    if(event is ProfessionalSelectCustomerShowAllCustomerEvent){
      List<Customer> customers = new List();
      customers = await CustomerRepository.defaultConstructor().getAllCustomersOfProfessional(event.professional.getProfessionalID().documentID);

      yield ProfessionalSelectCustomerShowAllCustomerState(professional: event.professional, customer: customers,selectedDateTime: event.selectedDateTime);


    }
  }

  @override
  ProfessionalSelectCustomerState get initialState => ProfessionalSelectCustomerInitial(professional:professional,selectedDateTime: selectedDateTime);
}
