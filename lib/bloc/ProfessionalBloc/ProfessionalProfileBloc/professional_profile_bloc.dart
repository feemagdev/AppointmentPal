import 'dart:async';

import 'package:appointmentproject/model/manager.dart';
import 'package:appointmentproject/model/professional.dart';
import 'package:appointmentproject/repository/appointment_repository.dart';
import 'package:appointmentproject/repository/person_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'professional_profile_event.dart';
part 'professional_profile_state.dart';

class ProfessionalProfileBloc
    extends Bloc<ProfessionalProfileEvent, ProfessionalProfileState> {
  final Professional professional;
  final Manager manager;
  ProfessionalProfileBloc({@required this.professional, this.manager});

  @override
  Stream<ProfessionalProfileState> mapEventToState(
    ProfessionalProfileEvent event,
  ) async* {
    if (event is GetAllDataForProfileEvent) {
      yield ProfessionalProfileLoadingState();
      User user = PersonRepository.defaultConstructor().getCurrentUser();
      String email = user.email;
      int totalCompletedAppointments =
          await AppointmentRepository.defaultConstructor()
              .getTotalNumberOfCompletedAppointments(
                  professional.getProfessionalID());
      int totalCanceledAppointments =
          await AppointmentRepository.defaultConstructor()
              .getTotalNumberOfCanceledAppointments(
                  professional.getProfessionalID());
      yield GetAllDataForProfileState(
          email: email,
          completedAppointments: totalCompletedAppointments,
          canceledAppointments: totalCanceledAppointments);
    }
  }

  @override
  ProfessionalProfileState get initialState => ProfessionalProfileInitial();
}
