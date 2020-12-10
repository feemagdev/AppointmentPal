import 'dart:async';

import 'package:appointmentproject/model/professional.dart';
import 'package:appointmentproject/repository/person_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'setting_screen_event.dart';
part 'setting_screen_state.dart';

class SettingScreenBloc extends Bloc<SettingScreenEvent, SettingScreenState> {
  final Professional professional;
  SettingScreenBloc({@required this.professional});

  @override
  Stream<SettingScreenState> mapEventToState(
    SettingScreenEvent event,
  ) async* {
    if (event is AddCustomerEvent) {
      yield AddCustomerState();
    } else if (event is AutomatedScheduleEvent) {
      yield AutomatedScheduleState();
    } else if (event is ManualBusinessHoursEvent) {
      yield ManualBusinessHoursState();
    } else if (event is ProfessionalEditProfileEvent) {
      yield ProfessionalEditProfileState();
    } else if (event is ProfessionalResetPasswordEvent) {
      try {
        yield ProfessionalSettingScreenLoadingState();
        User user = PersonRepository.defaultConstructor().getCurrentUser();
        await PersonRepository.defaultConstructor()
            .sendPasswordResetMail(user.email);
        yield ProfessionalResetPasswordSuccess();
      } catch (e) {
        yield ProfessionalResetPasswordFailure();
      }
    } else if (event is ProfessionalSmsPaymentEvent) {
      yield ProfessionalSmsPaymentState();
    }
  }

  @override
  SettingScreenState get initialState => SettingScreenInitial();
}
