import 'package:meta/meta.dart';

abstract class AddAppointmentEvent {}


class TapOnServiceEvent extends AddAppointmentEvent{
  final String serviceID;
  TapOnServiceEvent({@required this.serviceID});
}