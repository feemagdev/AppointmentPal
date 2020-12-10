part of 'manager_setting_screen_bloc.dart';

abstract class ManagerSettingScreenEvent {}

class ManagerResetPasswordEvent extends ManagerSettingScreenEvent {}

class ManagerSmsPaymentEvent extends ManagerSettingScreenEvent {}

class ManagerSettingScreenProfileEvent extends ManagerSettingScreenEvent {}
