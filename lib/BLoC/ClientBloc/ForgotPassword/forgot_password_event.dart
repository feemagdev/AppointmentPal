part of 'forgot_password_bloc.dart';

abstract class ForgotPasswordEvent {}

class SendPasswordResetLink extends ForgotPasswordEvent {
  final String email;

  SendPasswordResetLink({@required this.email});
}
