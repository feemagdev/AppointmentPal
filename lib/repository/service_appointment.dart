import 'package:firebase_database/firebase_database.dart';

class ServiceAppointment {
  String key;
  int serviceAppointmentId;
  DateTime appointmentDateTime;
  int serviceStatedDuration;
  int serviceProviderId;
  int serviceId;
  int clientId;

  ServiceAppointment(
      this.serviceAppointmentId,
      this.appointmentDateTime,
      this.serviceStatedDuration,
      this.serviceProviderId,
      this.serviceId,
      this.clientId);

  ServiceAppointment.fromSnapshot(DataSnapshot snapshot)
      : serviceAppointmentId = snapshot.value['serviceAppointmentId'],
        appointmentDateTime = snapshot.value['appointmentDateTime'],
        serviceStatedDuration = snapshot.value['serviceStatedDuration'],
        serviceProviderId = snapshot.value['serviceProviderId'],
        serviceId = snapshot.value['serviceId'],
        clientId = snapshot.value['clientId'];

  toJson() {
    return {
      'serviceAppointmentId': serviceAppointmentId,
      'appointmentDateTime': appointmentDateTime,
      'serviceStatedDuration': serviceStatedDuration,
      'serviceProviderId': serviceProviderId,
      'serviceId': serviceId,
      'clientId': clientId
    };
  }
}
