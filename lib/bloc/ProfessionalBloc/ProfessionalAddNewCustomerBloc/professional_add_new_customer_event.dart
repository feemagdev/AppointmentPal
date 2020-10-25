part of 'professional_add_new_customer_bloc.dart';

@immutable
abstract class ProfessionalAddNewCustomerEvent {}

class AddNewCustomerButtonPressedEvent extends ProfessionalAddNewCustomerEvent {
  final Professional professional;
  final DateTime appointmentStartTime;
  final DateTime appointmentEndTime;
  final String name;
  final String phone;
  final String address;
  final String city;
  final String country;

  AddNewCustomerButtonPressedEvent(
      {@required this.professional,
      this.name,
      this.appointmentStartTime,
      this.phone,
      this.address,
      this.city,
      this.country,
      this.appointmentEndTime});
}

class MoveBackToSelectCustomerScreenEvent
    extends ProfessionalAddNewCustomerEvent {
  final Professional professional;
  final DateTime appointmentStartTime;
  final DateTime appointmentEndTime;
  final Appointment appointment;
  final Customer customer;

  MoveBackToSelectCustomerScreenEvent(
      {@required this.professional,
      @required this.appointmentStartTime,
      @required this.appointmentEndTime,
      this.appointment,
      this.customer});
}

class AddCustomerAgainEvent extends ProfessionalAddNewCustomerEvent {
  final Professional professional;
  final DateTime appointmentStartTime;
  final DateTime appointmentEndTime;
  final String name;
  final String phone;
  final String address;
  final String city;
  final String country;

  AddCustomerAgainEvent(
      {@required this.professional,
      this.name,
      this.appointmentStartTime,
      this.phone,
      this.address,
      this.city,
      this.country,
      this.appointmentEndTime});
}

class CheckPhoneEvent extends ProfessionalAddNewCustomerEvent {
  final String phone;
  final Professional professional;

  CheckPhoneEvent({@required this.phone, @required this.professional});
}
