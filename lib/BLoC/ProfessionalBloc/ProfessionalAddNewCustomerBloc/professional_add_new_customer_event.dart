part of 'professional_add_new_customer_bloc.dart';

@immutable
abstract class ProfessionalAddNewCustomerEvent {}

class AddNewCustomerButtonPressedEvent extends ProfessionalAddNewCustomerEvent {
  final Professional professional;
  final DateTime selectedDateTime;
  final String name;
  final String phone;
  final Schedule schedule;

  AddNewCustomerButtonPressedEvent({@required this.professional,this.name,this.selectedDateTime,this.phone,this.schedule});

}


class MoveBackToSelectCustomerScreenEvent extends ProfessionalAddNewCustomerEvent {
  final Professional professional;
  final Schedule schedule;
  final DateTime appointmentTime;

  MoveBackToSelectCustomerScreenEvent ({@required this.professional,@required this.schedule,@required this.appointmentTime});

}
