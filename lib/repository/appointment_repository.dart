import 'package:appointmentproject/model/appointment.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AppointmentRepository {
  AppointmentRepository.defaultConstructor();

  Future<bool> professionalMakeAppointment(
      String professionalID,
      String customerID,
      Timestamp appointmentStartTime,
      Timestamp appointmentEndTime,
      String appointmentStatus) async {
    final dbReference = FirebaseFirestore.instance;
    Appointment appointment = Appointment.bookAppointment();
    await dbReference.collection('appointment').add(
        appointment.professionalAppointmentMap(
            professionalID,
            customerID,
            appointmentStartTime,
            appointmentEndTime,
            changeTime(appointmentStartTime),
            appointmentStatus));

    return true;
  }

  Future<List<Appointment>> getNotAvailableTime(
      Timestamp timeStamp, String professionalID) async {
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
          appointment.add(Appointment.notAvailableTime(
              element.data(), element.reference.id));
        });
      });
    } catch (e) {}

    if (appointment.length == 0) {
      return appointment;
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
        Appointment appointment = Appointment.getClientAppointments(
            element.data(), element.reference.id);
        appointments.add(appointment);
      });
    });
    return appointments;
  }

  Future<List<Appointment>> getProfessionalSelectedDayAppointments(
      String professionalID, Timestamp timestamp) async {
    final dbReference = FirebaseFirestore.instance;
    List<Appointment> appointments = List();
    Timestamp newTimeStamp = changeTime(timestamp);
    await dbReference
        .collection('appointment')
        .where('appointment_date', isEqualTo: newTimeStamp)
        .where('professionalID', isEqualTo: professionalID)
        .where('appointment_status', isEqualTo: 'booked')
        .orderBy('appointment_start_time')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        Appointment appointment = Appointment.getProfessionalAppointments(
            element.data(), element.reference.id);
        print(element.data);
        appointments.add(appointment);
      });
    });
    return appointments;
  }

  DocumentReference getAppointmentReference(String appointmentID) {
    return FirebaseFirestore.instance
        .collection('appointment')
        .doc(appointmentID);
  }

  Future<bool> updateAppointment(Appointment appointment) async {
    final dbReference = FirebaseFirestore.instance;
    Map<String, dynamic> updateMap = appointment.updateMap(
        appointment.getProfessionalID(),
        appointment.getCustomerID(),
        appointment.getAppointmentStartTime(),
        appointment.getAppointmentEndTime(),
        changeTime(appointment.getAppointmentStartTime()));

    await dbReference
        .collection('appointment')
        .doc(appointment.getAppointmentID())
        .set(updateMap, SetOptions(merge: true));

    return true;
  }

  Future<List<Appointment>> getTodayAppointmentOfProfessional(
      String professionalID) async {
    DateTime dateTime =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    final dbReference = FirebaseFirestore.instance;
    List<Appointment> appointments = List();
    await dbReference
        .collection('appointment')
        .where('professionalID', isEqualTo: professionalID)
        .where('appointment_date', isEqualTo: Timestamp.fromDate(dateTime))
        .where('appointment_end_time', isLessThanOrEqualTo: Timestamp.now())
        .where('appointment_status', isEqualTo: 'booked')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        Appointment appointment = Appointment.getProfessionalAppointments(
            element.data(), element.reference.id);
        appointments.add(appointment);
      });
    });
    return appointments;
  }

  Future<bool> markTheAppointmentComplete(Appointment appointment) async {
    final dbReference = FirebaseFirestore.instance;
    await dbReference
        .collection('appointment')
        .doc(appointment.getAppointmentID())
        .update({'appointment_status': 'completed'});
    return true;
  }

  Future<bool> markTheAppointmentCancel(Appointment appointment) async {
    final dbReference = FirebaseFirestore.instance;
    await dbReference
        .collection('appointment')
        .doc(appointment.getAppointmentID())
        .update({'appointment_status': 'canceled'});
    return true;
  }

  Future<List<Appointment>> getCompletedAppointmentList(
      String professionalID, DateTime dateTime) async {
    final dbReference = FirebaseFirestore.instance;
    List<Appointment> appointmentList = List();
    DateTime checkingDate =
        DateTime(dateTime.year, dateTime.month, dateTime.day);
    print(changeTime(Timestamp.fromDate(checkingDate)));
    QuerySnapshot querySnapshot = await dbReference
        .collection('appointment')
        .where('professionalID', isEqualTo: professionalID)
        .where('appointment_date',
            isEqualTo: changeTime(Timestamp.fromDate(checkingDate)))
        .where('appointment_status', isEqualTo: 'completed')
        .orderBy('appointment_start_time')
        .get();
    querySnapshot.docs.forEach((element) {
      print(element.data());
      Appointment appointment = Appointment.getProfessionalAppointments(
          element.data(), element.reference.id);
      appointmentList.add(appointment);
    });
    return appointmentList;
  }

  Future<List<Appointment>> getCanceledAppointmentList(
      String professionalID, DateTime dateTime) async {
    final dbReference = FirebaseFirestore.instance;
    List<Appointment> appointmentList = List();
    DateTime checkingDate =
        DateTime(dateTime.year, dateTime.month, dateTime.day);
    print(changeTime(Timestamp.fromDate(checkingDate)));
    QuerySnapshot querySnapshot = await dbReference
        .collection('appointment')
        .where('professionalID', isEqualTo: professionalID)
        .where('appointment_date',
            isEqualTo: changeTime(Timestamp.fromDate(checkingDate)))
        .where('appointment_status', isEqualTo: 'canceled')
        .orderBy('appointment_start_time')
        .get();
    querySnapshot.docs.forEach((element) {
      print(element.data());
      Appointment appointment = Appointment.getProfessionalAppointments(
          element.data(), element.reference.id);
      appointmentList.add(appointment);
    });
    return appointmentList;
  }

  Future<int> getTotalNumberOfCompletedAppointments(
      String professionalID) async {
    final dbReference = FirebaseFirestore.instance;
    int totalApponitments = 0;

    QuerySnapshot query = await dbReference
        .collection('appointment')
        .where('professionalID', isEqualTo: professionalID)
        .where('appointment_status', isEqualTo: 'completed')
        .get();

    totalApponitments = query.size;
    return totalApponitments;
  }

  Future<int> getTotalNumberOfCanceledAppointments(
      String professionalID) async {
    final dbReference = FirebaseFirestore.instance;
    int totalApponitments = 0;

    QuerySnapshot query = await dbReference
        .collection('appointment')
        .where('professionalID', isEqualTo: professionalID)
        .where('appointment_status', isEqualTo: 'canceled')
        .get();

    totalApponitments = query.size;
    return totalApponitments;
  }

  Future<bool> cancelAppointment(String appointmentID) async {
    final dbReference = FirebaseFirestore.instance;
    await dbReference.collection('appointment').doc(appointmentID).delete();
    return true;
  }
}
