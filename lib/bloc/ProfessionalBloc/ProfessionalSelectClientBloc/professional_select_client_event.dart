part of 'professional_select_client_bloc.dart';

abstract class ProfessionalSelectClientEvent {}

class GetClientListEvent extends ProfessionalSelectClientEvent {}

class ClientSearchingEvent extends ProfessionalSelectClientEvent {
  final List<Customer> customerList;
  final String query;
  ClientSearchingEvent({@required this.customerList, @required this.query});
}

class ProfessionalSelectedClientEvent extends ProfessionalSelectClientEvent {
  final Customer customer;
  ProfessionalSelectedClientEvent({@required this.customer});
}
