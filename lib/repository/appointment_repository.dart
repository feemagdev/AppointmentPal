import 'package:appointmentproject/BLoC/ProfessionalBloc/bloc.dart';
import 'package:appointmentproject/model/appointment.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AppointmentRepository {
  AppointmentRepository.defaultConstructor();

  makeAppointment(
      DocumentReference professionalID,
      DocumentReference serviceID,
      DocumentReference subServiceID,
      DocumentReference clientID,
      Timestamp dateTime,
      String appointmentStatus,
      String name,
      String phone,
      String professionalName,
      String professionalContact,
      String serviceName,
      String subServiceName) {
    final dbReference = Firestore.instance;
    Appointment appointment = Appointment.bookAppointment();

    dbReference.collection('appointment').add(appointment.toMap(
        professionalID,
        serviceID,
        subServiceID,
        clientID,
        dateTime,
        changeTime(dateTime),
        appointmentStatus,
        name,
        phone,
        professionalName,
        professionalContact,
        serviceName,
        subServiceName));
  }

  professionalMakeAppointment(
      DocumentReference professionalID,
      DocumentReference customerID,
      Timestamp appointmentDateTime,
      String appointmentStatus) {
    final dbReference = Firestore.instance;
    Appointment appointment = Appointment.bookAppointment();
    dbReference.collection('appointment').add(
        appointment.professionalAppointmentMap(
            professionalID,
            customerID,
            appointmentDateTime,
            changeTime(appointmentDateTime),
            appointmentStatus));
  }

  Future<List<Appointment>> getNotAvailableTime(
      Timestamp timeStamp, DocumentReference professionalID) async {
    Timestamp newTimeStamp = changeTime(timeStamp);
    List<Appointment> appointment = List();

    try {
      final dbReference = Firestore.instance;
      await dbReference
          .collection('appointment')
          .where('appointment_date', isEqualTo: newTimeStamp)
          .where('professionalID', isEqualTo: professionalID)
          .getDocuments()
          .then((value) {
        value.documents.forEach((element) {
          appointment.add(
              Appointment.notAvailableTime(element.data, element.reference));
          print('added');
        });
      });
    } catch (e) {
      print(e);
    }

    if (appointment.length == 0) {
      print('null return');
      return null;
    }
    return appointment;
  }

  Timestamp changeTime(Timestamp timestamp) {
    DateTime dateTime = timestamp.toDate();
    DateTime newDateTime =
        DateTime(dateTime.year, dateTime.month, dateTime.day);
    return Timestamp.fromDate(newDateTime);
  }

  Future<List<Appointment>> getClientSelectedDayAppointments(
      DocumentReference clientID, Timestamp timestamp) async {
    final dbReference = Firestore.instance;
    List<Appointment> appointments = List();
    Timestamp newTimeStamp = changeTime(timestamp);
    await dbReference
        .collection('appointment')
        .where('appointment_date', isEqualTo: newTimeStamp)
        .where('clientID', isEqualTo: clientID)
        .getDocuments()
        .then((value) {
      value.documents.forEach((element) {
        Appointment appointment =
            Appointment.getClientAppointments(element.data, element.reference);
        appointments.add(appointment);
      });
    });
    return appointments;
  }

  Future<List<Appointment>> getProfessionalSelectedDayAppointments(
      DocumentReference professionalID, Timestamp timestamp) async {
    final dbReference = Firestore.instance;
    List<Appointment> appointments = List();
    Timestamp newTimeStamp = changeTime(timestamp);
    await dbReference
        .collection('appointment')
        .where('appointment_date', isEqualTo: newTimeStamp)
        .where('professionalID', isEqualTo: professionalID)
        .getDocuments()
        .then((value) {
      value.documents.forEach((element) {
        Appointment appointment = Appointment.getProfessionalAppointments(
            element.data, element.reference);
        appointments.add(appointment);
      });
    });
    return appointments;
  }

  DocumentReference getAppointmentReference(String appointmentID) {
    return Firestore.instance.collection('appointment').document(appointmentID);
  }

  Future<void> updateAppointment(Appointment appointment, String clientName,
      String clientPhone, Timestamp appointmentDateTime) async {
    final dbReference = Firestore.instance;
    await dbReference
        .collection('appointment')
        .document(appointment.getAppointmentID().documentID)
        .setData(
            appointment.updateMap(
                appointment.getProfessionalID(),
                clientName,
                clientPhone,
                appointmentDateTime,
                changeTime(appointmentDateTime)),
            merge: true);
  }
}
