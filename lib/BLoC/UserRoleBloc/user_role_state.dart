
import 'package:appointmentproject/model/service.dart';
import 'package:appointmentproject/repository/service_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

@immutable
abstract class UserRoleState {}

class InitialUserRoleState extends UserRoleState {}

class ClientState extends UserRoleState{
  final FirebaseUser user;
  ClientState({@required this.user});
}

class ProfessionalState extends UserRoleState{
  final FirebaseUser user;
  ProfessionalState({@required this.user});
}

class ClientDetailsNotFilled extends UserRoleState{
  final List<Service> services;
  ClientDetailsNotFilled({@required this.services});
}


