import 'dart:async';

import 'package:appointmentproject/model/manager.dart';
import 'package:appointmentproject/repository/person_repository.dart';
import 'package:appointmentproject/repository/professional_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:random_string/random_string.dart';

part 'manager_add_professional_event.dart';

part 'manager_add_professional_state.dart';

class ManagerAddProfessionalBloc
    extends Bloc<ManagerAddProfessionalEvent, ManagerAddProfessionalState> {
  final Manager manager;

  ManagerAddProfessionalBloc({@required this.manager});

  @override
  Stream<ManagerAddProfessionalState> mapEventToState(
    ManagerAddProfessionalEvent event,
  ) async* {
    if (event is ManagerAddProfessionalButtonPressedEvent) {
      User user;
      try {
        user = await PersonRepository.defaultConstructor()
            .registerUser(event.email, randomAlphaNumeric(10));
        await PersonRepository.defaultConstructor()
            .sendPasswordResetMail(user.email);

        bool addedSuccessfully =
            await ProfessionalRepository.defaultConstructor().addProfessional(
                professionalID: user.uid,
                name: event.name,
                phone: event.phone,
                city: event.city,
                address: event.address,
                country: event.country,
                managerID: manager.getManagerID());

        if (addedSuccessfully) {
          yield ManagerAddedProfessionalSuccessfullyState();
        }
      } catch (e) {
        if (e.code == 'email-already-in-use') {
          yield ProfessionalNotRegisteredSuccessfullyState(
              errorMessage: "Email already in use");
        } else if (e.code == 'invalid-email') {
          yield ProfessionalNotRegisteredSuccessfullyState(
              errorMessage: "Invalid email");
        } else if (e.code == 'operation-not-allowed') {
          yield ProfessionalNotRegisteredSuccessfullyState(
              errorMessage: "This email is disabled");
        } else if (e.code == 'weak-password') {
          yield ProfessionalNotRegisteredSuccessfullyState(
              errorMessage: "Please use a strong password");
        } else {
          yield ProfessionalNotRegisteredSuccessfullyState(
              errorMessage: e.toString());
        }
      }
    }
  }

  @override
  ManagerAddProfessionalState get initialState =>
      ManagerAddProfessionalInitial();
}
