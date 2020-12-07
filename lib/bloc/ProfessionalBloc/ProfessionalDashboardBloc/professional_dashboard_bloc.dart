import 'dart:async';

import 'package:appointmentproject/model/professional.dart';
import 'package:appointmentproject/repository/person_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'professional_dashboard_event.dart';
part 'professional_dashboard_state.dart';

class ProfessionalDashboardBloc
    extends Bloc<ProfessionalDashboardEvent, ProfessionalDashboardState> {
  @override
  Stream<ProfessionalDashboardState> mapEventToState(
    ProfessionalDashboardEvent event,
  ) async* {
    if (event is ProfessionalAddAppointmentEvent) {
      yield ProfessionalAddAppointmentState(professional: event.professional);
    } else if (event is ProfessionalEditAppointmentEvent) {
      yield ProfessionalEditAppointmentState(professional: event.professional);
    } else if (event is ProfessionalTodayAppointmentEvent) {
      yield ProfessionalTodayAppointmentState(professional: event.professional);
    } else if (event is ProfessionalSettingEvent) {
      yield ProfessionalSettingState(professional: event.professional);
    } else if (event is ProfessionalHistoryEvent) {
      yield ProfessionalHistoryState(professional: event.professional);
    } else if (event is ProfessionalLogOutEvent) {
      yield ProfessionalDashboardLoadingState();
      await PersonRepository.defaultConstructor().signOut();
      yield ProfessionalLogOutSuccessfullyState();
    }
  }

  @override
  ProfessionalDashboardState get initialState => ProfessionalDashboardInitial();
}
