part of 'professional_select_client_bloc.dart';

abstract class ProfessionalSelectClientState {}

class ProfessionalSelectClientInitial extends ProfessionalSelectClientState {}

class ProfessionalSelectClientLoadingState
    extends ProfessionalSelectClientState {}

class GetClientListState extends ProfessionalSelectClientState {
  final List<Customer> customers;
  GetClientListState({@required this.customers});
}

class NoCustomerFoundState extends ProfessionalSelectClientState {}

class ClientSearchingState extends ProfessionalSelectClientState {
  final List<Customer> filteredList;
  final List<Customer> customerList;

  ClientSearchingState(
      {@required this.filteredList, @required this.customerList});
}

class ClientSelectedState extends ProfessionalSelectClientState {
  final Customer customer;
  ClientSelectedState({@required this.customer});
}
