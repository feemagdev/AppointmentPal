import 'package:appointmentproject/model/week_days_availability.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class WeekDaysAvailabilityRepository {
  WeekDaysAvailabilityRepository.defaultConstructor();

  Future<WeekDaysAvailability> getListOfAvailableWeekDays(
      String professionalID) async {
    final dbReference = FirebaseFirestore.instance;
    WeekDaysAvailability weekDaysAvailability =
        WeekDaysAvailability.defaultConstructor();
    DocumentSnapshot snapshot = await dbReference
        .collection('custom_time_slot')
        .doc(professionalID)
        .get();
    if (snapshot.exists) {
      weekDaysAvailability = WeekDaysAvailability.fromMap(snapshot.data());
      return weekDaysAvailability;
    } else {
      return null;
    }
  }

  Future<WeekDaysAvailability> updateWeekDaysAvailability(
      String professionalID, WeekDaysAvailability weekDaysAvailability) async {
    final dbReference = FirebaseFirestore.instance;
    await dbReference.collection('custom_time_slot').doc(professionalID).set(
        WeekDaysAvailability.defaultConstructor().toMap(
          weekDaysAvailability.getMondayAvailability(),
          weekDaysAvailability.getTuesdayAvailability(),
          weekDaysAvailability.getWednesdayAvailability(),
          weekDaysAvailability.getThursdayAvailability(),
          weekDaysAvailability.getFridayAvailability(),
          weekDaysAvailability.getSaturdayAvailability(),
          weekDaysAvailability.getSundayAvailability(),
        ),
        SetOptions(merge: true));
    return weekDaysAvailability;
  }
}
