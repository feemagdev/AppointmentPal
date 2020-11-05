part of 'professional_add_new_customer_bloc.dart';

@immutable
abstract class ProfessionalAddNewCustomerState {}

class ProfessionalAddNewCustomerInitial
    extends ProfessionalAddNewCustomerState {
  final Professional professional;
  final DateTime appointmentStartTime;
  final DateTime appointmentEndTime;

  ProfessionalAddNewCustomerInitial(
      {@required this.professional,
      this.appointmentStartTime,
      this.appointmentEndTime});
}

class CustomerAddedSuccessfullyState extends ProfessionalAddNewCustomerState {
  final Customer customer;
  CustomerAddedSuccessfullyState({@required this.customer});
}

class MoveBackToSelectCustomerScreenState
    extends ProfessionalAddNewCustomerState {
  final Professional professional;
  final DateTime appointmentEndTime;
  final DateTime appointmentStartTime;

  MoveBackToSelectCustomerScreenState(
      {@required this.professional,
      @required this.appointmentStartTime,
      @required this.appointmentEndTime});
}

class CustomerAlreadyExistState extends ProfessionalAddNewCustomerState {
  final Professional professional;

  CustomerAlreadyExistState({@required this.professional});
}

class CustomerCanBeAdded extends ProfessionalAddNewCustomerState {
  final Professional professional;
  CustomerCanBeAdded({@required this.professional});
}


class AddNewCustomerAgainState extends ProfessionalAddNewCustomerState {
  final Professional professional;
  final DateTime appointmentStartTime;
  final DateTime appointmentEndTime;
  final String name;
  final String phone;
  final String address;
  final String city;
  final String country;

  AddNewCustomerAgainState(
      {@required this.professional,
        this.name,
        this.appointmentStartTime,
        this.phone,
        this.address,
        this.city,
        this.country,
        this.appointmentEndTime});
}
