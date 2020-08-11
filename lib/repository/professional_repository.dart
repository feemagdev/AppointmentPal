

import 'package:appointmentproject/model/professional.dart';
import 'package:firebase_database/firebase_database.dart';

class ProfessionalRepository {
  FirebaseDatabase firebaseDatabase;
  ProfessionalRepository(){
    firebaseDatabase = FirebaseDatabase.instance;
  }

}
