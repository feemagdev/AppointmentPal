
import 'package:appointmentproject/model/sub_services.dart';
import 'package:meta/meta.dart';


abstract class AddAppointmentState {}

class InitialAddAppointmentState extends AddAppointmentState {}

class TapOnServiceState extends AddAppointmentState {
  List<SubServices> subServicesList;
  TapOnServiceState({@required this.subServicesList});
}