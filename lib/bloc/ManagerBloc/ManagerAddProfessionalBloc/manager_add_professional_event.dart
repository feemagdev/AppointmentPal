part of 'manager_add_professional_bloc.dart';

abstract class ManagerAddProfessionalEvent {}

class ManagerAddProfessionalButtonPressedEvent
    extends ManagerAddProfessionalEvent {
  final String email;
  final String name;
  final String phone;
  final String address;
  final String city;
  final String country;
  final String managerEmail;
  final String managerPassword;

  ManagerAddProfessionalButtonPressedEvent(
      {@required this.name,
      @required this.email,
      @required this.address,
      @required this.city,
      @required this.country,
      @required this.phone,@required this.managerEmail,@required this.managerPassword});
}

class ManagerAddProfessionalVerificationEvent extends ManagerAddProfessionalEvent {
  final String email;
  final String password;
  ManagerAddProfessionalVerificationEvent({@required this.email,@required this.password});
}

