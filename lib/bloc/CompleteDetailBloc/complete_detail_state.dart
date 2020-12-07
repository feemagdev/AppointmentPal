part of 'complete_detail_bloc.dart';

abstract class CompleteDetailState {}

class CompleteDetailInitial extends CompleteDetailState {}

class ProfessionalRegisrteredSuccessfullyState extends CompleteDetailState {
  final Professional professional;
  ProfessionalRegisrteredSuccessfullyState({@required this.professional});
}

class RegistrationFailedState extends CompleteDetailState {}

class CompleteRegistrationLoadingState extends CompleteDetailState {}

class ManagerRegisrteredSuccessfullyState extends CompleteDetailState {
  final Manager manager;
  ManagerRegisrteredSuccessfullyState({@required this.manager});
}
