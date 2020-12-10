part of 'manager_dashboard_bloc.dart';

abstract class ManagerDashboardState {}

class ManagerDashboardInitial extends ManagerDashboardState {}

class ManagerDashboardAddProfessionalState extends ManagerDashboardState {}

class ManagerDashboardAddAppointmentState extends ManagerDashboardState {}

class ManagerDashboardEditAppointmentState extends ManagerDashboardState {}

class ManagerLogOutSuccess extends ManagerDashboardState {}

class ManagerDashboardLoadingState extends ManagerDashboardState {}
