

import 'package:appointmentproject/model/professional.dart';
import 'package:firebase_database/firebase_database.dart';

class ProfessionalRepository {
  FirebaseDatabase firebaseDatabase;
  ProfessionalRepository(){
    firebaseDatabase = FirebaseDatabase.instance;
  }



  Future<void> registerProfessional(Professional professional){
    return firebaseDatabase.reference().child('professional').push().set(professional.toJson());
  }
}
