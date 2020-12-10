import 'dart:io';

import 'package:appointmentproject/model/manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

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

  Future<bool> updateManagerData(Manager manager) async {
    final dbReference = FirebaseFirestore.instance;
    await dbReference.collection('manager').doc(manager.getManagerID()).set({
      'name': manager.getName(),
      'phone': manager.getPhone(),
      'address': manager.getAddress()
    }, SetOptions(merge: true));
    return true;
  }

  Future<bool> uploadImageToFirebase(
      File imageFile, String managerID, String oldImage) async {
    if (oldImage != "") {
      if (oldImage != null) {
        final storageReference = FirebaseStorage.instance;
        await storageReference.refFromURL(oldImage).delete();
      }
    }

    Reference reference =
        FirebaseStorage.instance.ref().child('profiles/$managerID');
    UploadTask uploadTask = reference.putFile(imageFile);
    TaskSnapshot taskSnapshot = await uploadTask;
    final String url = await taskSnapshot.ref.getDownloadURL();
    final dbReference = FirebaseFirestore.instance;

    await dbReference
        .collection('manager')
        .doc(managerID)
        .set({'image': url}, SetOptions(merge: true));

    return true;
  }
}
