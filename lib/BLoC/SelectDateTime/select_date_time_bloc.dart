import 'dart:async';

import 'package:appointmentproject/model/professional.dart';
import 'package:appointmentproject/model/schedule.dart';
import 'package:appointmentproject/repository/schedule_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'select_date_time_event.dart';
part 'select_date_time_state.dart';

class SelectDateTimeBloc extends Bloc<SelectDateTimeEvent, SelectDateTimeState> {

  final Professional professional;
  SelectDateTimeBloc({@required this.professional});


  @override
  SelectDateTimeState get initialState => SelectDateTimeInitial(professional:professional);

  @override
  Stream<SelectDateTimeState> mapEventToState(
    SelectDateTimeEvent event,
  ) async* {
    if(event is ShowAvailableTimeEvent){
      Schedule schedule = await getProfessionalSchedule(event.professional,event.dateTime);
      yield ShowAvailableTimeState(professional: event.professional,schedule: schedule);

    }
  }

  Future<Schedule> getProfessionalSchedule(Professional professional,DateTime dateTime) async {
    print("in get schedule");
    String convertedDay;
    if(dateTime == null){
      dateTime = DateTime.now();
    }
    print(dateTime.toString());
      convertedDay = getDay(dateTime);

    print("in get professional schedule");
    Schedule schedule =  await ScheduleRepository.defaultConstructor().getProfessionalSchedule(professional.getProfessionalID(),convertedDay);
    return schedule;
  }






  String getDay(DateTime dateTime) {
    String convertedDay;
    int day = dateTime.weekday;
    print("in get day function");
    print(day);
    if(day == DateTime.monday){
      convertedDay = 'Monday';
    }else if(day == DateTime.tuesday){
      convertedDay = 'Tuesday';
    }else if(day == DateTime.wednesday){
      convertedDay = 'Wednesday';
    }else if(day == DateTime.thursday){
      convertedDay = 'Thursday';
    }else if(day == DateTime.friday){
      convertedDay = 'Friday';
    }
    else if(day == DateTime.saturday){
      convertedDay = 'Saturday';
    }else{
      convertedDay = 'Sunday';
    }
    return convertedDay;
  }

}
