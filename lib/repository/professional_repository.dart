


import 'package:appointmentproject/model/professional.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfessionalRepository {


  ProfessionalRepository.defaultConstructor();


  Future<List<Professional>> getListOfProfessionalsBySubService(
      DocumentReference subServiceID) async {
    List<Professional> listOfProfessionals = [];
    final dbReference = FirebaseFirestore.instance;
    dbReference
        .collection('professional')
        .where('sub_serviceID', isEqualTo: subServiceID)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        Professional professional;
        professional = Professional.fromMap(element.data(),element.reference);
        listOfProfessionals.add(professional);
      });
    });
    return listOfProfessionals;
  }

  DocumentReference getProfessionalReference(String professionalID){
    return FirebaseFirestore.instance.collection('professional').doc(professionalID);

  }

  Future<Professional> getProfessionalData(User user) async {
    final dbReference = FirebaseFirestore.instance;
    Professional professional;
    DocumentSnapshot snapshot = await dbReference.collection('professional').doc(user.uid).get();

    if(snapshot.exists){
      professional = Professional.fromMap(snapshot.data(), snapshot.reference);
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







}