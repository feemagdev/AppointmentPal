part of 'professional_payment_bloc.dart';

abstract class ProfessionalPaymentState {}

class ProfessionalPaymentInitial extends ProfessionalPaymentState {}

class ProfessionalAddPaymentState extends ProfessionalPaymentState {
  final int amount;
  ProfessionalAddPaymentState({@required this.amount});
}

class ProfessionalPaymentAlreadyPaidState extends ProfessionalPaymentState {}
