import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

@immutable
abstract class CompleteRegistrationBlocEvent {}


// ignore: must_be_immutable
class CompleteRegistrationButtonPressedEvent extends CompleteRegistrationBlocEvent{
  String name;
  String address;
  String phone;
  FirebaseUser user;
  CompleteRegistrationButtonPressedEvent({@required this.name,@required this.address,@required this.phone,@required this.user});
}