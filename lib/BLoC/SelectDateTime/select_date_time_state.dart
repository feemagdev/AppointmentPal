part of 'select_date_time_bloc.dart';

@immutable
abstract class SelectDateTimeState {}

class SelectDateTimeInitial extends SelectDateTimeState {
  final Professional professional;
  SelectDateTimeInitial({@required this.professional});
}

class ShowAvailableTimeState extends SelectDateTimeState{
  final Professional professional;
  final Schedule schedule;

  ShowAvailableTimeState({@required this.professional,@required this.schedule});

}


