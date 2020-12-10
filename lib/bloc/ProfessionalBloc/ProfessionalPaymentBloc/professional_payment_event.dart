part of 'professional_payment_bloc.dart';

abstract class ProfessionalPaymentEvent {}

class ProfessionalPaymentButtonEvent extends ProfessionalPaymentEvent {
  final int amount;
  ProfessionalPaymentButtonEvent({@required this.amount});
}
