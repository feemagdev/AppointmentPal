import 'package:cloud_firestore/cloud_firestore.dart';

class Appointment {
  String _appointmentID;
  String _professionalID;
  String _customerID;
  Timestamp _appointmentStartTime;
  Timestamp _appointmentEndTime;
  Timestamp _appointmentDate;
  String _appointmentStatus;

  Appointment.bookAppointment();

  Appointment.updateAppointment();

  Map<String, dynamic> updateMap(
      String professionalID,
      String customerID,
      Timestamp appointmentStartTime,
      Timestamp appointmentEndTime,
      Timestamp appointmentDate) {
    return {
      'professionalID': professionalID,
      'customerID': customerID,
      'appointment_start_time': appointmentStartTime,
      'appointment_end_time': appointmentEndTime,
      'appointment_date': appointmentDate,
    };
  }

  Map<String, dynamic> professionalAppointmentMap(String professionalID,
      String customerID,
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

  Appointment.notAvailableTime(Map snapshot, String appointmentID)
      : _appointmentID = appointmentID,
        _appointmentDate = snapshot['appointment_date'],
        _appointmentStartTime = snapshot['appointment_start_time'],
        _appointmentEndTime = snapshot['appointment_end_time'];

  Appointment.getClientAppointments(Map snapshot, String appointmentID)
      : _appointmentID = appointmentID,
        _appointmentDate = snapshot['appointment_date'],
        _appointmentStartTime = snapshot['appointment_start_time'],
        _professionalID = snapshot['professionalID'],
        _appointmentEndTime = snapshot['appointment_end_time'];

  Appointment.getProfessionalAppointments(Map snapshot, String appointmentID)
      : _appointmentID = appointmentID,
        _appointmentDate = snapshot['appointment_date'],
        _appointmentStartTime = snapshot['appointment_start_time'],
        _appointmentEndTime = snapshot['appointment_end_time'],
        _professionalID = snapshot['professionalID'],
        _appointmentStatus = snapshot['appointment_status'],
        _customerID = snapshot['customerID'];

  String getAppointmentID() {
    return _appointmentID;
  }

  String getCustomerID() {
    return _customerID;
  }

  String getProfessionalID() {
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

  void setAppointmentStartTime(Timestamp appointmentStartTime) {
    _appointmentStartTime = appointmentStartTime;
  }

  void setAppointmentEndTime(Timestamp appointmentEndTime) {
    _appointmentEndTime = appointmentEndTime;
  }

  void setCustomerID(String customerID) {
    _customerID = customerID;
  }
}
