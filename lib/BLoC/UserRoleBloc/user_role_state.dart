
import 'package:appointmentproject/model/client.dart';
import 'package:appointmentproject/model/professional.dart';
import 'package:appointmentproject/model/service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

@immutable
abstract class UserRoleState {}

class InitialUserRoleState extends UserRoleState {}

class ClientState extends UserRoleState{
  final FirebaseUser user;
  final Client client;
  ClientState({@required this.user, @required this.client});
}

class ProfessionalState extends UserRoleState{
  final Professional professional;
  ProfessionalState({@required this.professional});
}

class ClientDetailsNotFilled extends UserRoleState{
  final List<Service> services;
  ClientDetailsNotFilled({@required this.services});
}


