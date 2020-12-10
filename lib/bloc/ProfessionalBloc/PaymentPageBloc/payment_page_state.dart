part of 'payment_page_bloc.dart';

abstract class PaymentPageState {}

class PaymentPageInitial extends PaymentPageState {}

class PaymentSuccessState extends PaymentPageState {}

class PaymentPageLoadingState extends PaymentPageState {}

class PaymentFailureState extends PaymentPageState {}

class ProfessionalPaymentSuccessState extends PaymentPageState {}

class ProfessionalPaymentFailureState extends PaymentPageState {}

class ManagerPaymentSuccessState extends PaymentPageState {}
