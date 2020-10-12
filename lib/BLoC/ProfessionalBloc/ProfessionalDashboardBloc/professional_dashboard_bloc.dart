import 'dart:async';

import 'package:appointmentproject/model/professional.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'professional_dashboard_event.dart';
part 'professional_dashboard_state.dart';

class ProfessionalDashboardBloc extends Bloc<ProfessionalDashboardEvent, ProfessionalDashboardState> {

  @override
  Stream<ProfessionalDashboardState> mapEventToState(
    ProfessionalDashboardEvent event,
  ) async* {
    if(event is ProfessionalAddAppointmentEvent){
      yield ProfessionalAddAppointmentState(professional: event.professional);
    }
    else if(event is ProfessionalEditAppointmentEvent){
      yield ProfessionalEditAppointmentState(professional: event.professional);
    }
  }

  @override
  ProfessionalDashboardState get initialState => ProfessionalDashboardInitial();
}
