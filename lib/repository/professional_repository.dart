


import 'package:cloud_firestore/cloud_firestore.dart';

class ProfessionalRepository {


  ProfessionalRepository.defaultConstructor();



  DocumentReference getProfessionalReference(String professionalID){
    final dbReference = Firestore.instance;
    return dbReference.collection('professional').document(professionalID);
  }



}