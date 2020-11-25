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
      schedule =
          Schedule.professionalSchedule(snapshot.data(), snapshot.reference.id);
    }
    return schedule;
  }

  Future<bool> updateSchedule(
      Schedule schedule, String professionalID, String day) async {
    final dbReference = FirebaseFirestore.instance;
    Map<String, dynamic> scheduleMap = {
      'start_time': schedule.getStartTime(),
      'start_time_minutes': schedule.getStartTimeMinutes(),
      'end_time': schedule.getEndTime(),
      'end_time_minutes': schedule.getEndTimeMinutes(),
      'break_start_time': schedule.getBreakStartTime(),
      'break_start_time_minutes': schedule.getBreakStartTimeMinutes(),
      'break_end_time': schedule.getBreakEndTime(),
      'break_end_time_minutes': schedule.getBreakEndTimeMinutes(),
      'duration': schedule.getDuration()
    };
    await dbReference
        .collection(scheduleCollection)
        .doc(professionalID)
        .collection(dayOfWeekSubCollection)
        .doc(day)
        .set(scheduleMap);

    return true;
  }
}
