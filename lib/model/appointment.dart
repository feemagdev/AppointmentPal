import 'package:appointmentproject/model/client.dart';
import 'package:appointmentproject/model/professional.dart';
import 'package:appointmentproject/model/service.dart';
import 'package:appointmentproject/model/sub_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Appointment {
  String _appointmentID;
  Professional _professionalID;
  Service _serviceID;
  SubServices _subServicesID;
  Client _clientID;
  Timestamp _appointmentDateTime;
  Timestamp _appointmentDate;
  String _appointmentStatus;
  String _clientName;
  String _clientPhone;

  Appointment.bookAppointment();

  Map<String, dynamic> toMap(
    DocumentReference professionalID,
    DocumentReference serviceID,
    DocumentReference subServiceID,
    DocumentReference clientID,
    Timestamp appointmentDateTime,
    Timestamp appointmentDate,
    String appointmentStatus,
    String clientName,
    String clientPhone,
  ) {
    return {
      'professionalID': professionalID,
      'clientID': clientID,
      'serviceID': serviceID,
      'sub_serviceID': subServiceID,
      'appointment_date_time': appointmentDateTime,
      'appointment_date': appointmentDate,
      'appointment_status': appointmentStatus,
      'client_name': clientName,
      'client_phone': clientPhone,
    };
  }

  Appointment.notAvailableTime(Map snapshot, String appointmentID)
      : _appointmentID = appointmentID,
        _appointmentDate = snapshot['appointment_date'],
        _appointmentDateTime = snapshot['appointment_date_time'];

  String getAppointmentID() {
    return _appointmentID;
  }

  Client getClientReference() {
    return _clientID;
  }

  Professional getProfessionalID() {
    return _professionalID;
  }

  Service getClientService() {
    return _serviceID;
  }

  SubServices getSubServices() {
    return _subServicesID;
  }

  Timestamp getAppointmentDateTime() {
    return _appointmentDateTime;
  }

  Timestamp getAppointmentDate() {
    return _appointmentDate;
  }

  String getAppointmentStatus() {
    return _appointmentStatus;
  }

  String getClientName() {
    return _clientName;
  }

  String getClientPhone() {
    return _clientPhone;
  }
}
