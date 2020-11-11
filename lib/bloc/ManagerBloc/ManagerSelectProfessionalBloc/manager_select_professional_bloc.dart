import 'dart:async';

import 'package:appointmentproject/model/manager.dart';
import 'package:appointmentproject/model/professional.dart';
import 'package:appointmentproject/repository/professional_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'manager_select_professional_event.dart';
part 'manager_select_professional_state.dart';

class ManagerSelectProfessionalBloc extends Bloc<ManagerSelectProfessionalEvent,
    ManagerSelectProfessionalState> {
  final Manager manager;
  final String route;

  ManagerSelectProfessionalBloc({@required this.manager, this.route});

  @override
  Stream<ManagerSelectProfessionalState> mapEventToState(
    ManagerSelectProfessionalEvent event,
  ) async* {
    if (event is GetProfessionalsListEvent) {
      yield ManagerAddAppointmentLoadingState();
      List<Professional> professionals = List();
      professionals = await ProfessionalRepository.defaultConstructor()
          .getCompanyBasedProfessionalsList(manager.getManagerID());
      yield GetProfessionalsListState(professionals: professionals);
    } else if (event is ProfessionalSearchingEvent) {
      List<Professional> professionals = event.professionalsList;
      List<Professional> filtered = List();
      String string = event.query;
      professionals.forEach((element) {
        if (element.getName().toLowerCase().contains(string.toLowerCase()) ||
            element.getPhone().toLowerCase().contains(string.toLowerCase())) {
          filtered.add(element);
        }
      });

      yield ProfessionalSearchingState(
          filteredList: filtered, professionalsList: professionals);
    } else if (event is ManagerProfessionalSelectedEvent) {
      yield ManagerProfessionalSelectedState(
          professional: event.professional);
    }
  }

  @override
  ManagerSelectProfessionalState get initialState =>
      ManagerAddAppointmentInitial();
}
