import 'package:appointmentproject/model/week_days_availability.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class WeekDaysAvailabilityRepository {
  WeekDaysAvailabilityRepository.defaultConstructor();

  Future<WeekDaysAvailability> getListOfAvailableWeekDays(
      String professionalID) async {
    final dbReference = FirebaseFirestore.instance;
    WeekDaysAvailability weekDaysAvailability =
        WeekDaysAvailability.defaultConstructor();
    await dbReference
        .collection('CustomTimeSlot')
        .doc(professionalID)
        .get()
        .then((value) {
      weekDaysAvailability = WeekDaysAvailability.fromMap(value.data());
    });
    return weekDaysAvailability;
  }

  Future<WeekDaysAvailability> updateWeekDaysAvailability(
      String professionalID, WeekDaysAvailability weekDaysAvailability) async {
    final dbReference = FirebaseFirestore.instance;
    await dbReference
        .collection('CustomTimeSlot')
        .doc(professionalID)
        .update(WeekDaysAvailability.defaultConstructor().toMap(
          weekDaysAvailability.getMondayAvailability(),
          weekDaysAvailability.getTuesdayAvailability(),
          weekDaysAvailability.getWednesdayAvailability(),
          weekDaysAvailability.getThursdayAvailability(),
          weekDaysAvailability.getFridayAvailability(),
          weekDaysAvailability.getSaturdayAvailability(),
          weekDaysAvailability.getSundayAvailability(),
        ));
    return weekDaysAvailability;
  }
}
