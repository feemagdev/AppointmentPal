

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class SignUpEvent{}

class SignUpButtonPressedEvent extends SignUpEvent {

  final String email,password;
  SignUpButtonPressedEvent({@required this.email,@required this.password});


}