part of 'professional_edit_profile_bloc.dart';

abstract class ProfessionalEditProfileEvent {}

class UpdateProfessionalDetailEvent extends ProfessionalEditProfileEvent {
  final Professional professional;
  UpdateProfessionalDetailEvent({@required this.professional});
}

class UpdateProfessionalImageEvent extends ProfessionalEditProfileEvent {
  final File imageFile;
  UpdateProfessionalImageEvent({@required this.imageFile});
}

class ProfileEditGetProfessionalData extends ProfessionalEditProfileEvent {}
