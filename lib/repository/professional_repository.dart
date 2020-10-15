


import 'package:appointmentproject/model/professional.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfessionalRepository {


  ProfessionalRepository.defaultConstructor();


  Future<List<Professional>> getListOfProfessionalsBySubService(
      DocumentReference subServiceID) async {
    List<Professional> listOfProfessionals = [];
    final dbReference = Firestore.instance;
    dbReference
        .collection('professional')
        .where('sub_serviceID', isEqualTo: subServiceID)
        .getDocuments()
        .then((value) {
      value.documents.forEach((element) {
        Professional professional;
        professional = Professional.fromMap(element.data,element.reference);
        listOfProfessionals.add(professional);
      });
    });
    return listOfProfessionals;
  }

  DocumentReference getProfessionalReference(String professionalID){
    return Firestore.instance.collection('professional').document(professionalID);

  }

  Future<Professional> getProfessionalData(FirebaseUser user) async {
    print('in professional get data');
    final dbReference = Firestore.instance;
    Professional professional;
    DocumentSnapshot snapshot = await dbReference.collection('professional').document(user.uid).get();

    if(snapshot.exists){
      print('data returned of professional');
      professional = Professional.fromMap(snapshot.data, snapshot.reference);
      professional.getName();
      return professional;
    }
    print('null return');
    return null;


  }


  Future<bool> checkProfessionalDetails(String uid) async {
    final db = Firestore.instance;
    DocumentSnapshot data = await db.collection('professional').document(uid).get();
    return data.exists;
  }







}