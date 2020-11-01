import 'dart:async';

import 'package:appointmentproject/model/professional.dart';
import 'package:bloc/bloc.dart';
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
    if(event is AddCustomerEvent){
      yield AddCustomerState();
    }else if(event is AutomatedScheduleEvent){
      yield AutomatedScheduleState();
    }else if(event is ManualBusinessHoursEvent){
      yield ManualBusinessHoursState();
    }
  }

  @override
  SettingScreenState get initialState => SettingScreenInitial();
}
