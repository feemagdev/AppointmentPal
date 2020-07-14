

import 'package:appointmentproject/model/service.dart';
import 'package:meta/meta.dart';

abstract class ClientDashboardState {}

class InitialClientDashboardState extends ClientDashboardState {}

class MoveToSearchScreenState extends ClientDashboardState{}

class AddAppointmentScreenState extends ClientDashboardState{
  List<Service> serviceList;
  AddAppointmentScreenState({@required this.serviceList});
}
