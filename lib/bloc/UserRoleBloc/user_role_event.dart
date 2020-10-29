

import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

abstract class UserRoleEvent {}


class CheckUserRoleEvent extends UserRoleEvent{
  User user;
  CheckUserRoleEvent({@required this.user});
}