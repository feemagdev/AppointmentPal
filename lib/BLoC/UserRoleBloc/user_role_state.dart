
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

