import 'package:appointmentproject/model/schedule.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ScheduleRepository {
  final String scheduleCollection = "schedule";
  final String dayOfWeekSubCollection = "day_of_week";

  ScheduleRepository.defaultConstructor();

  Future<Schedule> getProfessionalSchedule(
      DocumentReference professionalID, String dayOfWeek) async {
    final dbReference = Firestore.instance;
    print("repository start");
    print(professionalID.documentID);
    print(dayOfWeek);
    Schedule schedule;
    await dbReference
        .collection('schedule')
        .document(professionalID.documentID)
        .collection(dayOfWeekSubCollection)
        .document(dayOfWeek)
        .get()
        .then((value) {
      if (value.data == null) {
        print("no data");
        return null;
      }
      schedule = Schedule.professionalSchedule(value.data);
    });
    print("Repository end");
    return schedule;
  }
}
