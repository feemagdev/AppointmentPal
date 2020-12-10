part of 'setting_screen_bloc.dart';

@immutable
abstract class SettingScreenState {}

class SettingScreenInitial extends SettingScreenState {}

class AddCustomerState extends SettingScreenState {}

class AutomatedScheduleState extends SettingScreenState {}

class ManualBusinessHoursState extends SettingScreenState {}

class ProfessionalEditProfileState extends SettingScreenState {}

class ProfessionalResetPasswordSuccess extends SettingScreenState {}

class ProfessionalResetPasswordFailure extends SettingScreenState {}

class ProfessionalSettingScreenLoadingState extends SettingScreenState {}

class ProfessionalSmsPaymentState extends SettingScreenState {}
