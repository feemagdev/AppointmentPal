import 'dart:async';

import 'package:appointmentproject/model/manager.dart';
import 'package:appointmentproject/model/professional.dart';
import 'package:appointmentproject/repository/manager_repository.dart';
import 'package:appointmentproject/repository/professional_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'complete_detail_event.dart';
part 'complete_detail_state.dart';

class CompleteDetailBloc
    extends Bloc<CompleteDetailEvent, CompleteDetailState> {
  final String uid;
  CompleteDetailBloc({@required this.uid});
  @override
  Stream<CompleteDetailState> mapEventToState(
    CompleteDetailEvent event,
  ) async* {
    if (event is CompleteRegistrationButtonEvent) {
      yield CompleteRegistrationLoadingState();
      try {
        if (event.type == "Professional") {
          bool check = await ProfessionalRepository.defaultConstructor()
              .addProfessional(
                  professionalID: uid,
                  managerID: "",
                  name: event.name,
                  address: event.address,
                  city: event.city,
                  country: event.country,
                  phone: event.phone);
          if (check) {
            Professional professional =
                await ProfessionalRepository.defaultConstructor()
                    .getProfessionalData(uid);
            yield ProfessionalRegisrteredSuccessfullyState(
                professional: professional);
          }
        } else {
          bool check = await ManagerRepository.defaultConstructor().addManager(
              managerID: uid,
              name: event.name,
              address: event.address,
              city: event.city,
              country: event.country,
              phone: event.phone);
          if (check) {
            Manager manager = await ManagerRepository.defaultConstructor()
                .getManagerData(uid);
            yield ManagerRegisrteredSuccessfullyState(manager: manager);
          }
        }
      } catch (e) {
        yield RegistrationFailedState();
      }
    }
  }

  @override
  CompleteDetailState get initialState => CompleteDetailInitial();
}
