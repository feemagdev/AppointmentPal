import 'package:appointmentproject/model/client.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';


abstract class CompleteRegistrationBlocState {}

class InitialCompleteRegistrationBlocState
    extends CompleteRegistrationBlocState {}

class SuccessfulCompleteRegistrationBlocState
    extends CompleteRegistrationBlocState {
  final FirebaseUser user;
  final Client client;
  SuccessfulCompleteRegistrationBlocState({@required this.user,@required this.client});
}

class FailureCompleteRegistrationBlocState
    extends CompleteRegistrationBlocState {
  final String message;

  FailureCompleteRegistrationBlocState({@required this.message});
}

class DatePickerState extends CompleteRegistrationBlocState {
  final DateTime dateTime;
  DatePickerState({@required this.dateTime});
}
