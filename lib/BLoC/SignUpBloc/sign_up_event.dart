

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class SignUpEvent extends Equatable{}

// ignore: must_be_immutable
class SignUpButtonPressedEvent extends SignUpEvent {

  String email,password;
  SignUpButtonPressedEvent({@required this.email,@required this.password});

  @override
  // TODO: implement props
  List<Object> get props => null;

}