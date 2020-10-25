part of 'professional_select_customer_bloc.dart';

@immutable
abstract class ProfessionalSelectCustomerEvent {}


class ProfessionalSelectCustomerShowAllCustomerEvent extends ProfessionalSelectCustomerEvent{
  final Professional professional;
  final DateTime appointmentStartTime;
  final DateTime appointmentEndTime;
  ProfessionalSelectCustomerShowAllCustomerEvent({@required this.professional,@required this.appointmentStartTime,this.appointmentEndTime});
}



class AddCustomerButtonPressedEvent extends ProfessionalSelectCustomerEvent{
  final Professional professional;
  final DateTime appointmentStartTime;
  final DateTime appointmentEndTime;

  AddCustomerButtonPressedEvent({@required this.professional,@required this.appointmentStartTime,this.appointmentEndTime});
}


class CustomerIsSelectedEvent extends ProfessionalSelectCustomerEvent {
  final Professional professional;
  final DateTime appointmentStartTime;
  final DateTime appointmentEndTime;
  final Customer customer;

  CustomerIsSelectedEvent({@required this.professional,@required this.appointmentStartTime,@required this.appointmentEndTime,@required this.customer});


}

class MoveBackToSelectDateTimeScreenEvent extends ProfessionalSelectCustomerEvent {
  final Professional professional;

  MoveBackToSelectDateTimeScreenEvent({@required this.professional});

}

class MoveBackToUpdateAppointmentScreenEvent extends ProfessionalSelectCustomerEvent {}


