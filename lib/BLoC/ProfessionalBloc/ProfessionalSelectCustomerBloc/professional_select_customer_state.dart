part of 'professional_select_customer_bloc.dart';

@immutable
abstract class ProfessionalSelectCustomerState {}

class ProfessionalSelectCustomerInitial
    extends ProfessionalSelectCustomerState {
  final Professional professional;
  final DateTime selectedDateTime;
  final Schedule schedule;

  ProfessionalSelectCustomerInitial(
      {@required this.professional,
      @required this.selectedDateTime,
      @required this.schedule});
}

class ProfessionalSelectCustomerShowAllCustomerState
    extends ProfessionalSelectCustomerState {
  final Professional professional;
  final List<Customer> customer;
  final DateTime selectedDateTime;
  final Schedule schedule;
  ProfessionalSelectCustomerShowAllCustomerState(
      {@required this.professional,
      @required this.customer,
      @required this.selectedDateTime,
      @required this.schedule});
}

class AddCustomerButtonPressedState extends ProfessionalSelectCustomerState {
  final Professional professional;
  final DateTime selectedDateTime;
  final Schedule schedule;

  AddCustomerButtonPressedState(
      {@required this.professional, @required this.selectedDateTime,this.schedule});
}

class CustomerIsSelectedState extends ProfessionalSelectCustomerState {
  final Professional professional;
  final DateTime appointmentTime;
  final Schedule schedule;
  final Customer customer;

  CustomerIsSelectedState({@required this.professional,@required this.appointmentTime,@required this.schedule,@required this.customer});
}


class MoveBackToSelectDateTimeScreenState extends ProfessionalSelectCustomerState {
  final Professional professional;
  MoveBackToSelectDateTimeScreenState({@required this.professional});
}
