part of 'email_verification_bloc.dart';


abstract class EmailVerificationState {}

class EmailVerificationInitial extends EmailVerificationState {}

class EmailVerified extends EmailVerificationState {
  final User user;
  EmailVerified({@required this.user});
}

class EmailNotVerified extends EmailVerificationState {}


class VerificationEmailSent extends EmailVerificationState {}


class VerificationSentFailedState extends EmailVerificationState {
  final String errorMessage;
  VerificationSentFailedState({@required this.errorMessage});
}
