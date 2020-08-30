import 'package:appointmentproject/model/professional.dart';
import 'package:appointmentproject/model/schedule.dart';
import 'package:appointmentproject/model/service.dart';
import 'package:appointmentproject/model/sub_services.dart';
import 'package:meta/meta.dart';

abstract class AddAppointmentEvent {}

class TapOnServiceEvent extends AddAppointmentEvent {
  final Service selectedService;

  TapOnServiceEvent({@required this.selectedService});
}

class TapOnSubServiceEvent extends AddAppointmentEvent {
  final Service selectedService;
  final SubServices selectedSubService;

  TapOnSubServiceEvent({@required this.selectedService, @required this.selectedSubService});
}

class NearByProfessionalsEvent extends AddAppointmentEvent {
  final List<Professional> professionals;
  final List<SubServices> subServices;
  final Service selectedService;
  final SubServices selectedSubService;

  NearByProfessionalsEvent(
      {@required this.professionals,
      @required this.subServices,
      @required this.selectedSubService,
      @required this.selectedService});
}

class AllProfessionalsEvent extends AddAppointmentEvent {
  final List<Professional> professionals;
  final List<SubServices> subServices;
  final Service selectedService;
  final SubServices selectedSubService;

  AllProfessionalsEvent(
      {@required this.professionals,
        @required this.subServices,
        @required this.selectedSubService,
        @required this.selectedService});
}

class NavigateToBookAppointmentEvent extends AddAppointmentEvent{
  final Professional professional;
  final SubServices selectedSubServices;
  final Service selectedService;
  NavigateToBookAppointmentEvent({@required this.professional,@required this.selectedService,@required this.selectedSubServices});
}
