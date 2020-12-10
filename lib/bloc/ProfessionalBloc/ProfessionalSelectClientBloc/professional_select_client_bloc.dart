import 'dart:async';

import 'package:appointmentproject/model/customer.dart';
import 'package:appointmentproject/model/professional.dart';
import 'package:appointmentproject/repository/customer_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'professional_select_client_event.dart';
part 'professional_select_client_state.dart';

class ProfessionalSelectClientBloc
    extends Bloc<ProfessionalSelectClientEvent, ProfessionalSelectClientState> {
  final Professional professional;
  ProfessionalSelectClientBloc({@required this.professional});
  @override
  Stream<ProfessionalSelectClientState> mapEventToState(
    ProfessionalSelectClientEvent event,
  ) async* {
    if (event is GetClientListEvent) {
      yield ProfessionalSelectClientLoadingState();
      List<Customer> customers = List();
      customers = await CustomerRepository.defaultConstructor()
          .getAllCustomersOfProfessional(professional.getProfessionalID());
      if (customers == null || customers.isEmpty) {
        yield NoCustomerFoundState();
      } else {
        yield GetClientListState(customers: customers);
      }
    } else if (event is ClientSearchingEvent) {
      List<Customer> customers = event.customerList;
      List<Customer> filtered = List();
      String string = event.query;
      customers.forEach((element) {
        if (element.getName().toLowerCase().contains(string.toLowerCase()) ||
            element.getPhone().toLowerCase().contains(string.toLowerCase())) {
          filtered.add(element);
        }
      });

      yield ClientSearchingState(
          filteredList: filtered, customerList: customers);
    } else if (event is ProfessionalSelectedClientEvent) {
      yield ClientSelectedState(customer: event.customer);
    }
  }

  @override
  ProfessionalSelectClientState get initialState =>
      ProfessionalSelectClientInitial();
}
