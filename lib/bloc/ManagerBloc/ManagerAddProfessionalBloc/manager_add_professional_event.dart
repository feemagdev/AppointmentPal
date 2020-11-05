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

  ManagerAddProfessionalButtonPressedEvent(
      {@required this.name,
      @required this.email,
      @required this.address,
      @required this.city,
      @required this.country,
      @required this.phone});
}
