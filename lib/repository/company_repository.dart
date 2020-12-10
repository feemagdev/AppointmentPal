import 'dart:io';

import 'package:appointmentproject/model/company.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ComapanyRepository {
  ComapanyRepository.defaultConstructor();

  Future<Company> getCompanyDetails(String companyID) async {
    final dbReference = FirebaseFirestore.instance;
    DocumentSnapshot snapshot =
        await dbReference.collection("company").doc(companyID).get();
    if (snapshot.data().isEmpty) {
      return null;
    } else {
      Company company = Company.fromMap(snapshot.data(), companyID);
      return company;
    }
  }

  Future<Company> addCompany(
      {String name, String address, String contact}) async {
    final dbReference = FirebaseFirestore.instance;
    DocumentReference documentReference = await dbReference
        .collection('company')
        .add({"name": name, "address": address, "contact": contact});

    DocumentSnapshot snapshot = await documentReference.get();
    if (snapshot.exists) {
      return Company.fromMap(snapshot.data(), snapshot.id);
    } else
      return null;
  }

  Future<bool> uploadImageToFirebase(
      File imageFile, String companyID, String oldImage) async {
    if (oldImage != "") {
      if (oldImage != null) {
        final storageReference = FirebaseStorage.instance;
        await storageReference.refFromURL(oldImage).delete();
      }
    }

    Reference reference =
        FirebaseStorage.instance.ref().child('profiles/$companyID');
    UploadTask uploadTask = reference.putFile(imageFile);
    TaskSnapshot taskSnapshot = await uploadTask;
    final String url = await taskSnapshot.ref.getDownloadURL();
    final dbReference = FirebaseFirestore.instance;

    await dbReference
        .collection('company')
        .doc(companyID)
        .set({'image': url}, SetOptions(merge: true));

    return true;
  }

  Future<bool> updateCompanyDetail(Company company) async {
    final dbReference = FirebaseFirestore.instance;
    await dbReference.collection('company').doc(company.getCompanyID()).set({
      'name': company.getName(),
      'contact': company.getContact(),
      'address': company.getCompanyAddress()
    }, SetOptions(merge: true));
    return true;
  }
}
