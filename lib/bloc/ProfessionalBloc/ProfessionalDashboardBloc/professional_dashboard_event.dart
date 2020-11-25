part of 'professional_dashboard_bloc.dart';

@immutable
abstract class ProfessionalDashboardEvent {}

class ProfessionalAddAppointmentEvent extends ProfessionalDashboardEvent {
  final Professional professional;
  ProfessionalAddAppointmentEvent({@required this.professional});
}

class ProfessionalEditAppointmentEvent extends ProfessionalDashboardEvent {
  final Professional professional;
  ProfessionalEditAppointmentEvent({@required this.professional});
}

class ProfessionalTodayAppointmentEvent extends ProfessionalDashboardEvent {
  final Professional professional;
  ProfessionalTodayAppointmentEvent({@required this.professional});
}

class ProfessionalSettingEvent extends ProfessionalDashboardEvent {
  final Professional professional;
  ProfessionalSettingEvent({@required this.professional});
}

class ProfessionalHistoryEvent extends ProfessionalDashboardEvent {
  final Professional professional;
  ProfessionalHistoryEvent({@required this.professional});
}
