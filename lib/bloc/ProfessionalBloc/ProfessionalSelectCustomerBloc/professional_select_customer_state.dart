part of 'professional_select_customer_bloc.dart';

@immutable
abstract class ProfessionalSelectCustomerState {}

class ProfessionalSelectCustomerInitial
    extends ProfessionalSelectCustomerState {
  final Professional professional;
  final DateTime appointmentStartTime;
  final DateTime appointmentEndTime;

  ProfessionalSelectCustomerInitial(
      {@required this.professional,
      @required this.appointmentStartTime,
      @required this.appointmentEndTime});
}

class ProfessionalSelectCustomerShowAllCustomerState
    extends ProfessionalSelectCustomerState {
  final Professional professional;
  final List<Customer> customer;
  final DateTime appointmentStartTime;
  final DateTime appointmentEndTime;
  ProfessionalSelectCustomerShowAllCustomerState(
      {@required this.professional,
      @required this.customer,
      @required this.appointmentStartTime,
      @required this.appointmentEndTime});
}

class AddCustomerButtonPressedState extends ProfessionalSelectCustomerState {
  final Professional professional;
  final DateTime appointmentStartTime;
  final DateTime appointmentEndTime;

  AddCustomerButtonPressedState(
      {@required this.professional, @required this.appointmentStartTime,this.appointmentEndTime});
}

class CustomerIsSelectedState extends ProfessionalSelectCustomerState {
  final Professional professional;
  final DateTime appointmentStartTime;
  final DateTime appointmentEndTime;
  final Customer customer;

  CustomerIsSelectedState({@required this.professional,@required this.appointmentStartTime,@required this.appointmentEndTime,@required this.customer});
}


class MoveBackToSelectDateTimeScreenState extends ProfessionalSelectCustomerState {
  final Professional professional;
  MoveBackToSelectDateTimeScreenState({@required this.professional});
}
