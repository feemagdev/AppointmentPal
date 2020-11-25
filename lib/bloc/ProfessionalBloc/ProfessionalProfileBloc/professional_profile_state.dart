part of 'professional_profile_bloc.dart';

abstract class ProfessionalProfileState {}

class ProfessionalProfileInitial extends ProfessionalProfileState {}

class GetAllDataForProfileState extends ProfessionalProfileState {
  final String email;
  final int completedAppointments;
  final int canceledAppointments;
  GetAllDataForProfileState(
      {@required this.email,
      @required this.completedAppointments,
      @required this.canceledAppointments});
}

class ProfessionalProfileLoadingState extends ProfessionalProfileState {}
