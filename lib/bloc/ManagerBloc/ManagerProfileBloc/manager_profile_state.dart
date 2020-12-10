part of 'manager_profile_bloc.dart';

abstract class ManagerProfileState {}

class ManagerProfileInitial extends ManagerProfileState {}

class ManagerProfileUpdateSuccessfullyState extends ManagerProfileState {}

class ManagerProfileImageUpdateSuccessfully extends ManagerProfileState {
  final Manager manager;
  ManagerProfileImageUpdateSuccessfully({@required this.manager});
}

class ManagerProfileLoadingState extends ManagerProfileState {}

class ManagerProfileUpdatedSuccessfully extends ManagerProfileState {
  final Manager manager;
  ManagerProfileUpdatedSuccessfully({@required this.manager});
}

class ProfileGetManagerDataState extends ManagerProfileState {
  final Manager manager;
  ProfileGetManagerDataState({@required this.manager});
}
