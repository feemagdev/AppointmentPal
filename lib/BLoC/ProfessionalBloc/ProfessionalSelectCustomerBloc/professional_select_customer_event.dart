part of 'professional_select_customer_bloc.dart';

@immutable
abstract class ProfessionalSelectCustomerEvent {}


class ProfessionalSelectCustomerShowAllCustomerEvent extends ProfessionalSelectCustomerEvent{
  final Professional professional;
  final DateTime selectedDateTime;
  final Schedule schedule;
  ProfessionalSelectCustomerShowAllCustomerEvent({@required this.professional,@required this.selectedDateTime,this.schedule});
}



class AddCustomerButtonPressedEvent extends ProfessionalSelectCustomerEvent{
  final Professional professional;
  final DateTime selectedDateTime;
  final Schedule schedule;
  AddCustomerButtonPressedEvent({@required this.professional,@required this.selectedDateTime,this.schedule});
}


class CustomerIsSelectedEvent extends ProfessionalSelectCustomerEvent {
  final Professional professional;
  final DateTime appointmentTime;
  final Schedule schedule;
  final Customer customer;

  CustomerIsSelectedEvent({@required this.professional,@required this.appointmentTime,@required this.schedule,@required this.customer});


}

class MoveBackToSelectDateTimeScreenEvent extends ProfessionalSelectCustomerEvent {
  final Professional professional;

  MoveBackToSelectDateTimeScreenEvent({@required this.professional});

}


