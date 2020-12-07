import 'package:appointmentproject/model/manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ManagerRepository {
  ManagerRepository.defaultConstructor();

  Future<Manager> getManagerData(String managerID) async {
    final dbReference = FirebaseFirestore.instance;
    DocumentSnapshot snapshot =
        await dbReference.collection('manager').doc(managerID).get();
    if (snapshot.exists) {
      return Manager.fromMap(snapshot.data(), snapshot.id);
    } else {
      return null;
    }
  }

  Future<bool> addManager(
      {String managerID,
      String name,
      String address,
      String city,
      String country,
      String phone}) async {
    final dbReference = FirebaseFirestore.instance;
    Map<String, dynamic> data = {
      "name": name,
      "address": address,
      "city": city,
      "country": country,
      "phone": phone,
    };
    await dbReference
        .collection('manager')
        .doc(managerID)
        .set(data, SetOptions(merge: true));
    return true;
  }

  Future<void> updateManager(String managerID, String companyID) async {
    final dbReference = FirebaseFirestore.instance;
    dbReference
        .collection('manager')
        .doc(managerID)
        .set({"companyID": companyID}, SetOptions(merge: true));
  }
}
