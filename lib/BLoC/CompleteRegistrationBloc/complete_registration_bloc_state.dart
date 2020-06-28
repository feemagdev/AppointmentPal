import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

@immutable
abstract class CompleteRegistrationBlocState {}

class InitialCompleteRegistrationBlocState extends CompleteRegistrationBlocState {}


class SuccessfulCompleteRegistrationBlocState extends CompleteRegistrationBlocState{

  final FirebaseUser user;

  SuccessfulCompleteRegistrationBlocState({@required this.user});


}
class FailureCompleteRegistrationBlocState extends CompleteRegistrationBlocState{

  final String message;
  FailureCompleteRegistrationBlocState({@required this.message});

}
