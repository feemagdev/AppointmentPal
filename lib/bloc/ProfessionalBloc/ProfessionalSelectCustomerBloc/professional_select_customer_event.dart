part of 'professional_select_customer_bloc.dart';

@immutable
abstract class ProfessionalSelectCustomerEvent {}

class ProfessionalSelectCustomerShowAllCustomerEvent
    extends ProfessionalSelectCustomerEvent {}

class AddCustomerButtonPressedEvent extends ProfessionalSelectCustomerEvent {}

class CustomerIsSelectedEvent extends ProfessionalSelectCustomerEvent {
  final Customer customer;

  CustomerIsSelectedEvent({@required this.customer});
}

class MoveBackToSelectDateTimeScreenEvent
    extends ProfessionalSelectCustomerEvent {
  final Professional professional;

  MoveBackToSelectDateTimeScreenEvent({@required this.professional});
}

class MoveBackToUpdateAppointmentScreenEvent
    extends ProfessionalSelectCustomerEvent {}
