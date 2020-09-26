


import 'package:appointmentproject/model/professional.dart';
import 'package:appointmentproject/model/sub_services.dart';
import 'package:appointmentproject/repository/sub_services_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfessionalRepository {


  ProfessionalRepository.defaultConstructor();



  DocumentReference getProfessionalReference(String professionalID){
    final dbReference = Firestore.instance;
    return dbReference.collection('professional').document(professionalID);
  }




}