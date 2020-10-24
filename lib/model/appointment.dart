import 'package:cloud_firestore/cloud_firestore.dart';

class Appointment {
  DocumentReference _appointmentID;
  DocumentReference _professionalID;
  DocumentReference _customerID;
  Timestamp _appointmentStartTime;
  Timestamp _appointmentEndTime;
  Timestamp _appointmentDate;
  String _appointmentStatus;

  Appointment.bookAppointment();

  Appointment.updateAppointment();

  Map<String, dynamic> updateMap(
      DocumentReference professionalID,
      String clientName,
      String clientPhone,
      Timestamp appointmentDateTime,
      Timestamp appointmentDate) {
    return {
      'professionalID': professionalID,
      'client_name': clientName,
      'client_phone': clientPhone,
      'appointment_date_time': appointmentDateTime,
      'appointment_date': appointmentDate,
    };
  }

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
      String professionalName,
      String professionalContact,
      String serviceName,
      String subServiceName) {
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
      'professional_name': professionalName,
      'professional_contact': professionalContact,
      'service_name': serviceName,
      'sub_service_name': subServiceName
    };
  }

  Map<String, dynamic> professionalAppointmentMap(
      DocumentReference professionalID,
      DocumentReference customerID,
      Timestamp appointmentStartTime,
      Timestamp appointmentEndTime,
      Timestamp appointmentDate,
      String appointmentStatus) {
    return {
      'professionalID': professionalID,
      'customerID': customerID,
      'appointment_status': appointmentStatus,
      'appointment_start_time': appointmentStartTime,
      'appointment_end_time': appointmentEndTime,
      'appointment_date': appointmentDate
    };
  }

  Appointment.notAvailableTime(Map snapshot, DocumentReference appointmentID)
      : _appointmentID = appointmentID,
        _appointmentDate = snapshot['appointment_date'],
        _appointmentStartTime = snapshot['appointment_start_time'],
        _appointmentEndTime = snapshot['appointment_end_time'];

  Appointment.getClientAppointments(
      Map snapshot, DocumentReference appointmentID)
      : _appointmentID = appointmentID,
        _appointmentDate = snapshot['appointment_date'],
        _appointmentStartTime = snapshot['appointment_start_time'],
        _professionalID = snapshot['professionalID'],
        _appointmentEndTime = snapshot['appointment_end_time'];

  Appointment.getProfessionalAppointments(
      Map snapshot, DocumentReference appointmentID)
      : _appointmentID = appointmentID,
        _appointmentDate = snapshot['appointment_date'],
        _appointmentStartTime = snapshot['appointment_start_time'],
        _appointmentEndTime = snapshot['appointment_end_time'],
        _professionalID = snapshot['professionalID'],
        _appointmentStatus = snapshot['appointment_status'],
        _customerID = snapshot['customerID'];

  DocumentReference getAppointmentID() {
    return _appointmentID;
  }

  DocumentReference getClientID() {
    return _customerID;
  }

  DocumentReference getProfessionalID() {
    return _professionalID;
  }

  Timestamp getAppointmentStartTime() {
    return _appointmentStartTime;
  }
  Timestamp getAppointmentEndTime() {
    return _appointmentEndTime;
  }

  Timestamp getAppointmentDate() {
    return _appointmentDate;
  }

  String getAppointmentStatus() {
    return _appointmentStatus;
  }


  void setAppointmentStartTime(Timestamp appointmentStartTime){
    _appointmentStartTime = appointmentStartTime;
  }
  void setAppointmentEndTime(Timestamp appointmentEndTime){
    _appointmentEndTime = appointmentEndTime;
  }


}
