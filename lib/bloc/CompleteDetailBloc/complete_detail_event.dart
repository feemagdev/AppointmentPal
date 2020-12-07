part of 'complete_detail_bloc.dart';

abstract class CompleteDetailEvent {}

class CompleteRegistrationButtonEvent extends CompleteDetailEvent {
  final String name;
  final String phone;
  final String address;
  final String city;
  final String country;
  final String type;
  CompleteRegistrationButtonEvent({
    @required this.name,
    @required this.phone,
    @required this.address,
    @required this.city,
    @required this.country,
    @required this.type,
  });
}
