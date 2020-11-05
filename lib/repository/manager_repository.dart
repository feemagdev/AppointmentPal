import 'package:appointmentproject/model/manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ManagerRepository {
  ManagerRepository.defaultConstructor();

  Future<Manager> getManagerData(String managerID) async {
    final dbReference = FirebaseFirestore.instance;
    Manager manager;
    await dbReference.collection('manager').doc(managerID).get().then((value) {
      manager = Manager.fromMap(value.data(), value.reference.id);
    });

    return manager;
  }
}
