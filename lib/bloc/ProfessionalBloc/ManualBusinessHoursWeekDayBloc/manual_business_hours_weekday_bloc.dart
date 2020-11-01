import 'dart:async';

import 'package:appointmentproject/model/professional.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'manual_business_hours_weekday_event.dart';
part 'manual_business_hours_weekday_state.dart';

class ManualBusinessHoursWeekdayBloc extends Bloc<ManualBusinessHoursWeekdayEvent, ManualBusinessHoursWeekdayState> {
  final Professional professional;

  ManualBusinessHoursWeekdayBloc({@required this.professional});


  @override
  Stream<ManualBusinessHoursWeekdayState> mapEventToState(
    ManualBusinessHoursWeekdayEvent event,
  ) async* {
    if(event is ManualBusinessHoursForMondayEvent){
      yield ManualBusinessHoursWeekdaySelectedState(day: 'Monday');
    } else if(event is ManualBusinessHoursForTuesdayEvent){

    } else if(event is ManualBusinessHoursForWednesdayEvent){

    }
  }

  @override
  ManualBusinessHoursWeekdayState get initialState => ManualBusinessHoursWeekdayInitial();
}
