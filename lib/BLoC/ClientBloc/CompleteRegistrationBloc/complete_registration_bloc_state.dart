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
  final String name;
  final String phone;
  final String country;
  final String city;
  final String address;
  final DateTime dob;
  DatePickerState({@required this.name,@required this.phone,@required this.country,@required this.city
    ,@required this.address,@required this.dob});
}
