part of 'professional_dashboard_bloc.dart';

@immutable
abstract class ProfessionalDashboardState {}

class ProfessionalDashboardInitial extends ProfessionalDashboardState {}


class ProfessionalAddAppointmentState extends ProfessionalDashboardState {
  final Professional professional;
  ProfessionalAddAppointmentState({@required this.professional});
}
class ProfessionalEditAppointmentState extends ProfessionalDashboardState {
  final Professional professional;
  ProfessionalEditAppointmentState({@required this.professional});
}

class ProfessionalTodayAppointmentState extends ProfessionalDashboardState {
  final Professional professional;
  ProfessionalTodayAppointmentState({@required this.professional});
}