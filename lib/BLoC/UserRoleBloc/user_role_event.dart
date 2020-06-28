import 'package:meta/meta.dart';

@immutable
abstract class UserRoleEvent {}


class CheckUserRoleEvent extends UserRoleEvent{}