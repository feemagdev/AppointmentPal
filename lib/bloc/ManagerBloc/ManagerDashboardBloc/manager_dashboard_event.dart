part of 'manager_dashboard_bloc.dart';

abstract class ManagerDashboardEvent {}

class ManagerDashboardAddProfessionalEvent extends ManagerDashboardEvent {}

class ManagerDashboardAddAppointmentEvent extends ManagerDashboardEvent {}

class ManagerDashboardEditAppointmentEvent extends ManagerDashboardEvent {}

class ManagerLogOutEvent extends ManagerDashboardEvent {}
