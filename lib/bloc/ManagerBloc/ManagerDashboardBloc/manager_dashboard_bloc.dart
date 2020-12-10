import 'dart:async';

import 'package:appointmentproject/model/manager.dart';
import 'package:appointmentproject/repository/person_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'manager_dashboard_event.dart';
part 'manager_dashboard_state.dart';

class ManagerDashboardBloc
    extends Bloc<ManagerDashboardEvent, ManagerDashboardState> {
  final Manager manager;

  ManagerDashboardBloc({@required this.manager});

  @override
  Stream<ManagerDashboardState> mapEventToState(
    ManagerDashboardEvent event,
  ) async* {
    if (event is ManagerDashboardAddProfessionalEvent) {
      yield ManagerDashboardAddProfessionalState();
    } else if (event is ManagerDashboardAddAppointmentEvent) {
      yield ManagerDashboardAddAppointmentState();
    } else if (event is ManagerDashboardEditAppointmentEvent) {
      yield ManagerDashboardEditAppointmentState();
    } else if (event is ManagerLogOutEvent) {
      yield ManagerDashboardLoadingState();
      await PersonRepository.defaultConstructor().signOut();
      yield ManagerLogOutSuccess();
    }
  }

  @override
  ManagerDashboardState get initialState => ManagerDashboardInitial();
}
