part of 'professional_select_customer_bloc.dart';

@immutable
abstract class ProfessionalSelectCustomerState {}

class ProfessionalSelectCustomerInitial extends ProfessionalSelectCustomerState {
  final Professional professional;
  final DateTime selectedDateTime;
  ProfessionalSelectCustomerInitial({@required this.professional,@required this.selectedDateTime});
}

class ProfessionalSelectCustomerShowAllCustomerState extends ProfessionalSelectCustomerState{
  final Professional professional;
  final List<Customer> customer;
  final DateTime selectedDateTime;
  ProfessionalSelectCustomerShowAllCustomerState({@required this.professional,@required this.customer,@required this.selectedDateTime});
}
