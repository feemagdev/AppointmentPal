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
    final dbReference = FirebaseFirestore.instance;
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
      Timestamp appointmentStartTime,
      Timestamp appointmentEndTime,
      String appointmentStatus) {
    final dbReference = FirebaseFirestore.instance;
    Appointment appointment = Appointment.bookAppointment();
    dbReference.collection('appointment').add(
        appointment.professionalAppointmentMap(
            professionalID,
            customerID,
            appointmentStartTime,
            appointmentEndTime,
            changeTime(appointmentStartTime),
            appointmentStatus));
  }

  Future<List<Appointment>> getNotAvailableTime(
      Timestamp timeStamp, DocumentReference professionalID) async {
    Timestamp newTimeStamp = changeTime(timeStamp);
    List<Appointment> appointment = List();

    try {
      final dbReference = FirebaseFirestore.instance;
      await dbReference
          .collection('appointment')
          .where('appointment_date', isEqualTo: newTimeStamp)
          .where('professionalID', isEqualTo: professionalID)
          .get()
          .then((value) {
        value.docs.forEach((element) {
          appointment.add(
              Appointment.notAvailableTime(element.data(), element.reference));
        });
      });
    } catch (e) {}

    if (appointment.length == 0) {
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
    final dbReference = FirebaseFirestore.instance;
    List<Appointment> appointments = List();
    Timestamp newTimeStamp = changeTime(timestamp);
    await dbReference
        .collection('appointment')
        .where('appointment_date', isEqualTo: newTimeStamp)
        .where('clientID', isEqualTo: clientID)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        Appointment appointment =
            Appointment.getClientAppointments(element.data(), element.reference);
        appointments.add(appointment);
      });
    });
    return appointments;
  }

  Future<List<Appointment>> getProfessionalSelectedDayAppointments(
      DocumentReference professionalID, Timestamp timestamp) async {
    final dbReference = FirebaseFirestore.instance;
    List<Appointment> appointments = List();
    Timestamp newTimeStamp = changeTime(timestamp);
    await dbReference
        .collection('appointment')
        .where('appointment_date', isEqualTo: newTimeStamp)
        .where('professionalID', isEqualTo: professionalID)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        Appointment appointment = Appointment.getProfessionalAppointments(
            element.data(), element.reference);
        print(element.data);
        appointments.add(appointment);
      });
    });
    return appointments;
  }

  DocumentReference getAppointmentReference(String appointmentID) {
    return FirebaseFirestore.instance.collection('appointment').doc(appointmentID);
  }

  Future<bool> updateAppointment(Appointment appointment) async {
    final dbReference = FirebaseFirestore.instance;
    Map<String,dynamic> updateMap = appointment.updateMap(
        appointment.getProfessionalID(),
        appointment.getCustomerID(),
        appointment.getAppointmentStartTime(),
        appointment.getAppointmentEndTime(),
        changeTime(appointment.getAppointmentStartTime()));

    await dbReference
        .collection('appointment')
        .doc(appointment.getAppointmentID().id)
        .set(
            updateMap);

    return true;
  }


  Future<List<Appointment>> getTodayAppointmentOfProfessional (DocumentReference professionalID) async {
    DateTime dateTime = DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day);
    final dbReference = FirebaseFirestore.instance;
    List<Appointment> appointments = List();
    await dbReference.collection('appointment')
        .where('professionalID',isEqualTo: professionalID)
        .where('appointment_date',isEqualTo: Timestamp.fromDate(dateTime))
        .where('appointment_end_time',isLessThanOrEqualTo: Timestamp.now())
    .where('appointment_status',isEqualTo: 'booked').get().then((value){
      value.docs.forEach((element) {
        Appointment appointment = Appointment.getProfessionalAppointments(element.data(), element.reference);
        appointments.add(appointment);
      });
    });
    return appointments;
  }

  Future<bool> markTheAppointmentComplete(Appointment appointment) async{
    await appointment.getAppointmentID().update({'appointment_status':'completed'});
    return true;
  }
  Future<bool> markTheAppointmentCancel(Appointment appointment) async{
    await appointment.getAppointmentID().update({'appointment_status':'canceled'});
    return true;
  }


}
