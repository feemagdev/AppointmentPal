part of 'setting_screen_bloc.dart';

@immutable
abstract class SettingScreenEvent {}

class AddCustomerEvent extends SettingScreenEvent {}

class AutomatedScheduleEvent extends SettingScreenEvent {}

class ManualBusinessHoursEvent extends SettingScreenEvent {}

class ProfessionalEditProfileEvent extends SettingScreenEvent {}

class ProfessionalResetPasswordEvent extends SettingScreenEvent {}

class ProfessionalSmsPaymentEvent extends SettingScreenEvent {}
