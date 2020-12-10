part of 'professional_edit_profile_bloc.dart';

abstract class ProfessionalEditProfileState {}

class ProfessionalEditProfileInitial extends ProfessionalEditProfileState {}

class ProfessionalEditProfileUpdateSuccessfullyState
    extends ProfessionalEditProfileState {}

class ProfessionalProfileImageUpdateSuccessfully
    extends ProfessionalEditProfileState {
  final Professional professional;
  ProfessionalProfileImageUpdateSuccessfully({@required this.professional});
}

class ProfessionalEditProfileLoadingState extends ProfessionalEditProfileState {
}

class ProfessionalProfileUpdatedSuccessfully
    extends ProfessionalEditProfileState {
  final Professional professional;
  ProfessionalProfileUpdatedSuccessfully({@required this.professional});
}

class ProfileEditGetProfessionalDataState extends ProfessionalEditProfileState {
  final Professional professional;
  ProfileEditGetProfessionalDataState({@required this.professional});
}
