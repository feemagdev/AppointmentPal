import 'package:appointmentproject/model/professional.dart';
import 'package:appointmentproject/model/service.dart';
import 'package:appointmentproject/model/sub_services.dart';
import 'package:meta/meta.dart';

abstract class AddAppointmentState {}

class InitialAddAppointmentState extends AddAppointmentState {}

class TapOnServiceState extends AddAppointmentState {
  List<SubServices> subServicesList;
  final Service selectedService;

  TapOnServiceState(
      {@required this.subServicesList, @required this.selectedService});
}

class TapOnSubServiceState extends AddAppointmentState {
  List<Professional> professionals;
  List<SubServices> subServicesList;
  final Service selectedService;
  final SubServices selectedSubService;

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
  final Service selectedService;
  final SubServices selectedSubService;

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
  final Service selectedService;
  final SubServices selectedSubService;

  AllProfessionalsState(
      {@required this.professionals,
        @required this.subServices,
        @required this.selectedService,
        @required this.selectedSubService,});
}

class LocationPermissionDeniedState extends AddAppointmentState{
  final List<Professional> professionals;
  final List<SubServices> subServices;
  final Service selectedService;
  final SubServices selectedSubService;

  LocationPermissionDeniedState(
      {@required this.professionals,
        @required this.subServices,
        @required this.selectedService,
        @required this.selectedSubService,});
}



class NavigateToBookAppointmentState extends AddAppointmentState {
  final Professional professional;
  final SubServices selectedSubServices;
  final Service selectedService;
  NavigateToBookAppointmentState({@required this.professional,@required this.selectedService,@required this.selectedSubServices});
}
