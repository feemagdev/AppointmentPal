
import 'package:appointmentproject/model/client.dart';
import 'package:meta/meta.dart';


abstract class ClientDashboardEvent {}


class SearchBarOnTapEvent extends ClientDashboardEvent {}

class AddAppointmentEvent extends ClientDashboardEvent{
  final Client client;
  AddAppointmentEvent({@required this.client});
}
