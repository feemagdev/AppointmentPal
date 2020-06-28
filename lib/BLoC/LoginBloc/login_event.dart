import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class LoginEvent extends Equatable{}

class LoginButtonPressed extends LoginEvent{
  String email,password;
  LoginButtonPressed({@required this.email,@required this.password});
  @override
  // TODO: implement props
  List<Object> get props => null;
}

