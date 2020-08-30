import 'package:appointmentproject/model/schedule.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ScheduleRepository {
  final String scheduleCollection = "schedule";
  final String dayOfWeekSubCollection = "day_of_week";

  ScheduleRepository.defaultConstructor();

  Future<Schedule> getProfessionalSchedule(
      String professionalID, String dayOfWeek) async {


    print("repository start");
    print(dayOfWeek);
    final dbReference = Firestore.instance;
    Schedule schedule;
    await dbReference
        .collection(scheduleCollection)
        .document(professionalID)
        .collection(dayOfWeekSubCollection)
        .document(dayOfWeek)
        .get()
        .then((value) {
          print(value.data);
      schedule = Schedule.professionalSchedule(value.data);
    });
    print("Repository end");
    return schedule;
  }
}
