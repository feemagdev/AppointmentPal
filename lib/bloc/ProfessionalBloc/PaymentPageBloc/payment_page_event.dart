part of 'payment_page_bloc.dart';

abstract class PaymentPageEvent {}

class PaymentSuccessEvent extends PaymentPageEvent {
  final int amount;
  PaymentSuccessEvent({@required this.amount});
}

class ProfessionalPaymentSuccessEvent extends PaymentPageEvent {
  final Payment payment;
  ProfessionalPaymentSuccessEvent({@required this.payment});
}

class PaymentFailureEvent extends PaymentPageEvent {}

class ProfessionalPaymentFailureEvent extends PaymentPageEvent {}
