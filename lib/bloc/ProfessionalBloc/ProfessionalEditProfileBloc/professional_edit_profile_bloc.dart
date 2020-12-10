import 'dart:async';
import 'dart:io';

import 'package:appointmentproject/model/professional.dart';
import 'package:appointmentproject/repository/professional_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'professional_edit_profile_event.dart';
part 'professional_edit_profile_state.dart';

class ProfessionalEditProfileBloc
    extends Bloc<ProfessionalEditProfileEvent, ProfessionalEditProfileState> {
  final Professional professional;
  ProfessionalEditProfileBloc({@required this.professional});
  @override
  Stream<ProfessionalEditProfileState> mapEventToState(
    ProfessionalEditProfileEvent event,
  ) async* {
    if (event is UpdateProfessionalDetailEvent) {
      yield ProfessionalEditProfileLoadingState();
      event.professional.setProfessionalID(professional.getProfessionalID());
      bool check = await ProfessionalRepository.defaultConstructor()
          .updateProfessionalData(event.professional);
      if (check) {
        Professional professional2 =
            await ProfessionalRepository.defaultConstructor()
                .getProfessionalData(professional.getProfessionalID());
        yield ProfessionalProfileUpdatedSuccessfully(
            professional: professional2);
      }
    } else if (event is ProfileEditGetProfessionalData) {
      yield ProfessionalEditProfileLoadingState();
      Professional newProfessional =
          await ProfessionalRepository.defaultConstructor()
              .getProfessionalData(professional.getProfessionalID());
      yield ProfileEditGetProfessionalDataState(professional: newProfessional);
    } else if (event is UpdateProfessionalImageEvent) {
      yield ProfessionalEditProfileLoadingState();
      bool check = await ProfessionalRepository.defaultConstructor()
          .uploadImageToFirebase(event.imageFile,
              professional.getProfessionalID(), professional.getImage());
      if (check) {
        Professional newProfessional =
            await ProfessionalRepository.defaultConstructor()
                .getProfessionalData(professional.getProfessionalID());
        yield ProfessionalProfileImageUpdateSuccessfully(
            professional: newProfessional);
      }
    }
  }

  @override
  ProfessionalEditProfileState get initialState =>
      ProfessionalEditProfileInitial();
}
