part of 'professional_select_customer_bloc.dart';

@immutable
abstract class ProfessionalSelectCustomerState {}

class ProfessionalSelectCustomerInitial
    extends ProfessionalSelectCustomerState {}

class ProfessionalSelectCustomerShowAllCustomerState
    extends ProfessionalSelectCustomerState {
  final List<Customer> customers;

  ProfessionalSelectCustomerShowAllCustomerState({
    @required this.customers,
  });
}

class AddCustomerButtonPressedState extends ProfessionalSelectCustomerState {}

class CustomerIsSelectedState extends ProfessionalSelectCustomerState {
  final Customer customer;

  CustomerIsSelectedState({@required this.customer});
}

class MoveBackToSelectDateTimeScreenState
    extends ProfessionalSelectCustomerState {
  final Professional professional;

  MoveBackToSelectDateTimeScreenState({@required this.professional});
}
