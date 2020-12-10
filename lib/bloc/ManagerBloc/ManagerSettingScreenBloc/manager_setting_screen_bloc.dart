import 'dart:async';

import 'package:appointmentproject/model/manager.dart';
import 'package:appointmentproject/repository/person_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'manager_setting_screen_event.dart';
part 'manager_setting_screen_state.dart';

class ManagerSettingScreenBloc
    extends Bloc<ManagerSettingScreenEvent, ManagerSettingScreenState> {
  final Manager manager;
  ManagerSettingScreenBloc({@required this.manager});

  @override
  Stream<ManagerSettingScreenState> mapEventToState(
    ManagerSettingScreenEvent event,
  ) async* {
    if (event is ManagerResetPasswordEvent) {
      try {
        yield ManagerSettingScreenLoadingState();
        User user = PersonRepository.defaultConstructor().getCurrentUser();
        await PersonRepository.defaultConstructor()
            .sendPasswordResetMail(user.email);
        yield ManagerResetPasswordSuccess();
      } catch (e) {
        yield ManagerResetPasswordFailure();
      }
    } else if (event is ManagerSmsPaymentEvent) {
      yield ManagerSmsPaymentState();
    } else if (event is ManagerSettingScreenProfileEvent) {
      yield ManagerSettingScreenProfileState();
    }
  }

  @override
  ManagerSettingScreenState get initialState => ManagerSettingScreenInitial();
}
