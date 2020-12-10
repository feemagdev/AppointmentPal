import 'dart:io';

import 'package:appointmentproject/model/professional.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ProfessionalRepository {
  ProfessionalRepository.defaultConstructor();

  Future<Professional> getProfessionalData(String professionalID) async {
    final dbReference = FirebaseFirestore.instance;
    Professional professional;
    DocumentSnapshot snapshot =
        await dbReference.collection('professional').doc(professionalID).get();

    if (snapshot.exists) {
      professional =
          Professional.fromMap(snapshot.data(), snapshot.reference.id);
      professional.getName();
      return professional;
    }
    return null;
  }

  Future<bool> checkProfessionalDetails(String uid) async {
    final db = FirebaseFirestore.instance;
    DocumentSnapshot data = await db.collection('professional').doc(uid).get();
    return data.exists;
  }

  Future<bool> addProfessional(
      {String professionalID,
      String managerID,
      String name,
      String address,
      String city,
      String country,
      String phone}) async {
    final dbReference = FirebaseFirestore.instance;
    Map<String, dynamic> data = {
      "managerID": managerID,
      "name": name,
      "address": address,
      "city": city,
      "country": country,
      "phone": phone,
    };
    await dbReference
        .collection('professional')
        .doc(professionalID)
        .set(data, SetOptions(merge: true));
    return true;
  }

  DocumentReference getProfessionalDocumentReference(String professionalID) {
    final dbReference = FirebaseFirestore.instance;
    DocumentReference documentReference =
        dbReference.collection('professional').doc(professionalID);
    return documentReference;
  }

  Future<List<Professional>> getCompanyBasedProfessionalsList(
      String managerID) async {
    final dbReference = FirebaseFirestore.instance;
    List<Professional> professionals = List();
    QuerySnapshot snapshot = await dbReference
        .collection('professional')
        .where('managerID', isEqualTo: managerID)
        .get();
    snapshot.docs.forEach((element) {
      professionals
          .add(Professional.fromMap(element.data(), element.reference.id));
    });
    return professionals;
  }

  Future<bool> updateProfessionalData(Professional professional) async {
    final dbReference = FirebaseFirestore.instance;
    await dbReference
        .collection('professional')
        .doc(professional.getProfessionalID())
        .set({
      'name': professional.getName(),
      'phone': professional.getPhone(),
      'address': professional.getAddress()
    }, SetOptions(merge: true));
    return true;
  }

  Future<bool> uploadImageToFirebase(
      File imageFile, String professionalID, String oldImage) async {
    if (oldImage != "") {
      if (oldImage != null) {
        final storageReference = FirebaseStorage.instance;
        await storageReference.refFromURL(oldImage).delete();
      }
    }

    Reference reference =
        FirebaseStorage.instance.ref().child('profiles/$professionalID');
    UploadTask uploadTask = reference.putFile(imageFile);
    TaskSnapshot taskSnapshot = await uploadTask;
    final String url = await taskSnapshot.ref.getDownloadURL();
    final dbReference = FirebaseFirestore.instance;

    await dbReference
        .collection('professional')
        .doc(professionalID)
        .set({'image': url}, SetOptions(merge: true));

    return true;
  }
}
