part of 'email_verification_bloc.dart';

abstract class EmailVerificationEvent {}

class SendEmailVerificationEvent extends EmailVerificationEvent {
  final FirebaseUser user;
  SendEmailVerificationEvent({@required this.user});
}

class CheckEmailVerification extends EmailVerificationEvent {
  final FirebaseUser user;
  CheckEmailVerification({@required this.user});
}
