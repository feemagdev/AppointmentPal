part of 'email_verification_bloc.dart';

abstract class EmailVerificationEvent {}

class SendEmailVerificationEvent extends EmailVerificationEvent {
  final User user;
  SendEmailVerificationEvent({@required this.user});
}

class CheckEmailVerification extends EmailVerificationEvent {
  final User user;
  CheckEmailVerification({@required this.user});
}
