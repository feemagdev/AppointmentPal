import 'package:appointmentproject/model/professional.dart';
import 'package:appointmentproject/model/sub_services.dart';
import 'package:meta/meta.dart';

abstract class AddAppointmentState {}

class InitialAddAppointmentState extends AddAppointmentState {}

class TapOnServiceState extends AddAppointmentState {
  List<SubServices> subServicesList;
  final String selectedService;

  TapOnServiceState(
      {@required this.subServicesList, @required this.selectedService});
}

class TapOnSubServiceState extends AddAppointmentState {
  List<Professional> professionals;
  List<SubServices> subServicesList;
  final String selectedService;
  final String selectedSubService;

  TapOnSubServiceState(
      {@required this.professionals,
      @required this.subServicesList,
      @required this.selectedService,
      @required this.selectedSubService});
}

class NearByProfessionalsState extends AddAppointmentState {
  final List<Professional> professionals;
  final List<SubServices> subServices;
  final List<double> distances;
  final String selectedService;
  final String selectedSubService;

  NearByProfessionalsState(
      {@required this.professionals,
      @required this.subServices,
      @required this.selectedService,
      @required this.selectedSubService,
      @required this.distances});
}

class AllProfessionalsState extends AddAppointmentState {
  final List<Professional> professionals;
  final List<SubServices> subServices;
  final String selectedService;
  final String selectedSubService;

  AllProfessionalsState(
      {@required this.professionals,
        @required this.subServices,
        @required this.selectedService,
        @required this.selectedSubService,});
}
