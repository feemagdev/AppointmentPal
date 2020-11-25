part of 'manager_add_professional_bloc.dart';

abstract class ManagerAddProfessionalState {}

class ManagerAddProfessionalInitial extends ManagerAddProfessionalState {}

class ProfessionalNotRegisteredSuccessfullyState
    extends ManagerAddProfessionalState {
  final String errorMessage;

  ProfessionalNotRegisteredSuccessfullyState({@required this.errorMessage});
}

class ManagerAddedProfessionalSuccessfullyState
    extends ManagerAddProfessionalState {}

class ManagerAddProfessionalLoadingState extends ManagerAddProfessionalState {}

class ManagerVerifiedSuccessfully extends ManagerAddProfessionalState {
  final String email;
  final String password;
  ManagerVerifiedSuccessfully({@required this.email,@required this.password});
}

class ManagerVerificationFailedState extends ManagerAddProfessionalState {
  final String message;

  ManagerVerificationFailedState({@required this.message});
}


