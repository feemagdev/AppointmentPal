
import 'package:appointmentproject/model/professional.dart';
import 'package:meta/meta.dart';

@immutable
abstract class UserRoleState {}

class InitialUserRoleState extends UserRoleState {}


class ProfessionalState extends UserRoleState{
  final Professional professional;
  ProfessionalState({@required this.professional});
}


