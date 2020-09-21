part of 'email_verification_bloc.dart';


abstract class EmailVerificationState {}

class EmailVerificationInitial extends EmailVerificationState {}

class EmailVerified extends EmailVerificationState {
  final FirebaseUser user;
  final List<Service> services;
  EmailVerified({@required this.user,@required this.services});
}

class EmailNotVerified extends EmailVerificationState {}


class VerificationEmailSent extends EmailVerificationState {}


class VerificationSentFailedState extends EmailVerificationState {
  final String errorMessage;
  VerificationSentFailedState({@required this.errorMessage});
}
