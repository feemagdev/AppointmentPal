part of 'manager_select_professional_bloc.dart';

abstract class ManagerSelectProfessionalState {}

class ManagerAddAppointmentInitial extends ManagerSelectProfessionalState {}

class GetProfessionalsListState extends ManagerSelectProfessionalState {
  final List<Professional> professionals;

  GetProfessionalsListState({@required this.professionals});
}

class ManagerAddAppointmentLoadingState extends ManagerSelectProfessionalState {
}

class ProfessionalSearchingState extends ManagerSelectProfessionalState {
  final List<Professional> filteredList;
  final List<Professional> professionalsList;

  ProfessionalSearchingState(
      {@required this.filteredList, @required this.professionalsList});
}

class ManagerProfessionalSelectedState extends ManagerSelectProfessionalState {
  final Professional professional;
  ManagerProfessionalSelectedState({@required this.professional});
}
