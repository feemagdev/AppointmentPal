part of 'forgot_password_bloc.dart';

abstract class ForgotPasswordState {}

class ForgotPasswordInitial extends ForgotPasswordState {}


class ForgotPasswordEmailSent extends ForgotPasswordState {}

class ForgotPasswordEmailNotSent extends ForgotPasswordState {
  final String message;
  ForgotPasswordEmailNotSent({@required this.message});
}