

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
      String phone) {
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
        phone));
  }

  Future<List<Appointment>> getNotAvailableTime(
      Timestamp timeStamp, DocumentReference professionalID) async {
    Timestamp newTimeStamp = changeTime(timeStamp);
    List<Appointment> appointment = List();

    try{
      final dbReference = Firestore.instance;
      await dbReference
          .collection('appointment')
          .where('appointment_date', isEqualTo: newTimeStamp)
          .where('professionalID', isEqualTo: professionalID)
          .getDocuments()
          .then((value) {
        value.documents.forEach((element) {
          appointment.add(Appointment.notAvailableTime(element.data, element.documentID));
          print('added');
        });
      });
    }catch(e){
      print(e);
    }

    if(appointment.length == 0){
      print('null return');
      return null;
    }
    return appointment;
  }


  Timestamp changeTime(Timestamp timestamp){
    DateTime dateTime = timestamp.toDate();
    DateTime newDateTime = DateTime(dateTime.year,dateTime.month,dateTime.day);
    return Timestamp.fromDate(newDateTime);
  }

}
