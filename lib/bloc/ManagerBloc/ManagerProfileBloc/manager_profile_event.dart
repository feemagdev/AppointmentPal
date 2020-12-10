part of 'manager_profile_bloc.dart';

abstract class ManagerProfileEvent {}

class UpdateManagerDetailEvent extends ManagerProfileEvent {
  final Manager manager;
  UpdateManagerDetailEvent({@required this.manager});
}

class UpdateManagerImageEvent extends ManagerProfileEvent {
  final File imageFile;
  UpdateManagerImageEvent({@required this.imageFile});
}

class ProfileGetManagerData extends ManagerProfileEvent {}
