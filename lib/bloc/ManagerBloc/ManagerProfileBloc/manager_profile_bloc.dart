import 'dart:async';
import 'dart:io';

import 'package:appointmentproject/model/manager.dart';
import 'package:appointmentproject/repository/manager_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'manager_profile_event.dart';
part 'manager_profile_state.dart';

class ManagerProfileBloc
    extends Bloc<ManagerProfileEvent, ManagerProfileState> {
  final Manager manager;
  ManagerProfileBloc({@required this.manager});
  @override
  Stream<ManagerProfileState> mapEventToState(
    ManagerProfileEvent event,
  ) async* {
    if (event is UpdateManagerDetailEvent) {
      yield ManagerProfileLoadingState();
      event.manager.setManagerID(manager.getManagerID());
      bool check = await ManagerRepository.defaultConstructor()
          .updateManagerData(event.manager);
      if (check) {
        Manager manager2 = await ManagerRepository.defaultConstructor()
            .getManagerData(manager.getManagerID());
        yield ManagerProfileUpdatedSuccessfully(manager: manager2);
      }
    } else if (event is ProfileGetManagerData) {
      yield ManagerProfileLoadingState();
      Manager newManager = await ManagerRepository.defaultConstructor()
          .getManagerData(manager.getManagerID());
      yield ProfileGetManagerDataState(manager: newManager);
    } else if (event is UpdateManagerImageEvent) {
      yield ManagerProfileLoadingState();
      bool check = await ManagerRepository.defaultConstructor()
          .uploadImageToFirebase(
              event.imageFile, manager.getManagerID(), manager.getImage());
      if (check) {
        Manager newManager = await ManagerRepository.defaultConstructor()
            .getManagerData(manager.getManagerID());
        yield ManagerProfileImageUpdateSuccessfully(manager: newManager);
      }
    }
  }

  @override
  ManagerProfileState get initialState => ManagerProfileInitial();
}
