import 'package:appointmentproject/model/custom_time_slots.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CustomTimeSlotRepository {
  CustomTimeSlotRepository.defaultConstructor();

  Future<bool> addCustomTimeSlot(
      DateTime from, DateTime to, String day, String professionalID) async {
    final dbReference = FirebaseFirestore.instance;
    CustomTimeSlots customTimeSlots = CustomTimeSlots.defaultConstructor();

    DocumentReference documentReference = await dbReference
        .collection('CustomTimeSlot')
        .doc(professionalID)
        .collection(day)
        .add(customTimeSlots.toMap(from, to));
    if (documentReference.id.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  Future<List<CustomTimeSlots>> getListOfCustomTimeSlotsOfSpecificDay(
      String day, String professionalID) async {
    List<CustomTimeSlots> customTimeSlots = List();
    final dbReference = FirebaseFirestore.instance;
    QuerySnapshot querySnapshot = await dbReference
        .collection('CustomTimeSlot')
        .doc(professionalID)
        .collection(day)
        .orderBy('from')
        .get();
    if (querySnapshot.docs.isEmpty) {
      return customTimeSlots;
    } else {
      querySnapshot.docs.forEach((element) {
        Timestamp fromTimestamp = element['from'];
        Timestamp toTimestamp = element['to'];

        customTimeSlots.add(CustomTimeSlots.fromMap(
            {'from': fromTimestamp.toDate(), 'to': toTimestamp.toDate()},
            element.id));
      });
      return customTimeSlots;
    }
  }
}
