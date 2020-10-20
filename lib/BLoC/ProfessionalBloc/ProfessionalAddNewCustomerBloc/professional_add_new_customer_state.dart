part of 'professional_add_new_customer_bloc.dart';

@immutable
abstract class ProfessionalAddNewCustomerState {}

class ProfessionalAddNewCustomerInitial extends ProfessionalAddNewCustomerState {
  final Professional professional;
  final DateTime selectedDateTime;
  final Schedule schedule;
  ProfessionalAddNewCustomerInitial({@required this.professional, this.selectedDateTime,this.schedule});
}

class CustomerAddedSuccessfullyState extends ProfessionalAddNewCustomerState {
  final Professional professional;
  final DateTime selectedDateTime;
  final Customer customer;
  final Schedule schedule;

  CustomerAddedSuccessfullyState({@required this.professional,this.selectedDateTime,this.customer,this.schedule});

}

class MoveBackToSelectCustomerScreenState extends ProfessionalAddNewCustomerState {
  final Professional professional;
  final Schedule schedule;
  final DateTime appointmentTime;

  MoveBackToSelectCustomerScreenState ({@required this.professional,@required this.schedule,@required this.appointmentTime});

}








