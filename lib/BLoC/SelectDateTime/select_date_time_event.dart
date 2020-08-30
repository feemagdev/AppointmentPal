part of 'select_date_time_bloc.dart';

@immutable
abstract class SelectDateTimeEvent {}


class ShowAvailableTimeEvent extends SelectDateTimeEvent{
  final Professional professional;
  final DateTime dateTime;

  ShowAvailableTimeEvent({@required this.professional,@required this.dateTime});

}




