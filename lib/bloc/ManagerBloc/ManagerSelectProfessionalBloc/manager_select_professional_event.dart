part of 'manager_select_professional_bloc.dart';

abstract class ManagerSelectProfessionalEvent {}

class GetProfessionalsListEvent extends ManagerSelectProfessionalEvent {}

class ProfessionalSearchingEvent extends ManagerSelectProfessionalEvent {
  final List<Professional> professionalsList;
  final String query;

  ProfessionalSearchingEvent(
      {@required this.professionalsList, @required this.query});
}

class ManagerProfessionalSelectedEvent extends ManagerSelectProfessionalEvent {
  final Professional professional;

  ManagerProfessionalSelectedEvent({@required this.professional});
}
