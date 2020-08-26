import 'package:appointmentproject/model/professional.dart';
import 'package:appointmentproject/model/sub_services.dart';
import 'package:meta/meta.dart';

abstract class AddAppointmentEvent {}

class TapOnServiceEvent extends AddAppointmentEvent {
  final String serviceID;

  TapOnServiceEvent({@required this.serviceID});
}

class TapOnSubServiceEvent extends AddAppointmentEvent {
  final String serviceID;
  final String subServiceID;

  TapOnSubServiceEvent({@required this.serviceID, @required this.subServiceID});
}

class NearByProfessionalsEvent extends AddAppointmentEvent {
  final List<Professional> professionals;
  final List<SubServices> subServices;
  final String selectedService;
  final String selectedSubService;

  NearByProfessionalsEvent(
      {@required this.professionals,
      @required this.subServices,
      @required this.selectedSubService,
      @required this.selectedService});
}

class AllProfessionalsEvent extends AddAppointmentEvent {
  final List<Professional> professionals;
  final List<SubServices> subServices;
  final String selectedService;
  final String selectedSubService;

  AllProfessionalsEvent(
      {@required this.professionals,
        @required this.subServices,
        @required this.selectedSubService,
        @required this.selectedService});
}
