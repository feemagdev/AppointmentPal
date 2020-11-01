import 'package:appointmentproject/model/schedule.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ScheduleRepository {
  final String scheduleCollection = "schedule";
  final String dayOfWeekSubCollection = "day_of_week";

  ScheduleRepository.defaultConstructor();

  Future<Schedule> getProfessionalSchedule(
      DocumentReference professionalID, String dayOfWeek) async {
    final dbReference = FirebaseFirestore.instance;
    print("repository start");
    print(professionalID.id);
    print(dayOfWeek);
    Schedule schedule;
    DocumentSnapshot snapshot = await dbReference
        .collection('schedule')
        .doc(professionalID.id)
        .collection(dayOfWeekSubCollection)
        .doc(dayOfWeek)
        .get();

    if(snapshot.data() == null){
      print("no data");
      return null;
    }else {
      schedule = Schedule.professionalSchedule(snapshot.data());
    }
    print("Repository end");
    return schedule;
  }
}
