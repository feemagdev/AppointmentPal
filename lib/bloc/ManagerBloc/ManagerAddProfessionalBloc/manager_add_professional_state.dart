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
