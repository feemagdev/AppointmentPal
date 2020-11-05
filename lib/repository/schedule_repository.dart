import 'package:appointmentproject/model/schedule.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ScheduleRepository {
  final String scheduleCollection = "schedule";
  final String dayOfWeekSubCollection = "day_of_week";

  ScheduleRepository.defaultConstructor();

  Future<Schedule> getProfessionalSchedule(
      String professionalID, String dayOfWeek) async {
    final dbReference = FirebaseFirestore.instance;
    Schedule schedule;
    DocumentSnapshot snapshot = await dbReference
        .collection('schedule')
        .doc(professionalID)
        .collection(dayOfWeekSubCollection)
        .doc(dayOfWeek)
        .get();

    if (snapshot.data() == null) {
      return null;
    } else {
      schedule = Schedule.professionalSchedule(snapshot.data());
    }
    return schedule;
  }
}
