import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

@immutable
abstract class CompleteRegistrationBlocEvent {}



class CompleteRegistrationButtonPressedEvent extends CompleteRegistrationBlocEvent{
  final String name;
  final String phone;
  final String country;
  final String city;
  final String address;
  final DateTime dob;
  final String need;
  final FirebaseUser user;
  CompleteRegistrationButtonPressedEvent({@required this.name,@required this.phone,@required this.country,@required this.city
  ,@required this.address,@required this.dob,@required this.need,@required this.user});
}

class DatePickerEvent extends CompleteRegistrationBlocEvent{
  final DateTime dateTime;
  DatePickerEvent({@required this.dateTime});
}