part of 'update_appointment_bloc.dart';

@immutable
abstract class UpdateAppointmentState {}

class UpdateAppointmentInitial extends UpdateAppointmentState {}

class UpdateAppointmentDateTimeState extends UpdateAppointmentState {}

class MoveToEditAppointmentScreenState extends UpdateAppointmentState {}


class UpdateAppointmentSelectCustomerState extends UpdateAppointmentState {}

class AppointmentUpdatedSuccessfullyState extends UpdateAppointmentState {}

class UpdateAppointmentLoadingState extends UpdateAppointmentState {}
