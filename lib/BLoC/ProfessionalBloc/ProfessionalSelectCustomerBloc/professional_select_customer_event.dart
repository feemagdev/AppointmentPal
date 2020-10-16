part of 'professional_select_customer_bloc.dart';

@immutable
abstract class ProfessionalSelectCustomerEvent {}


class ProfessionalSelectCustomerShowAllCustomerEvent extends ProfessionalSelectCustomerEvent{
  final Professional professional;
  final DateTime selectedDateTime;
  ProfessionalSelectCustomerShowAllCustomerEvent({@required this.professional,@required this.selectedDateTime});
}