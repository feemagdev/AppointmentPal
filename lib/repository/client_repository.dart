import 'package:appointmentproject/model/client.dart';
import 'package:appointmentproject/model/service.dart';
import 'package:appointmentproject/repository/service_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

class ClientRepository {




  ClientRepository.defaultConstructor();




  Future<void> registerClient(Client client) async {
    final dbReference = Firestore.instance;
    await dbReference
        .collection('client')
        .document(client.getFirebaseUser().uid)
        .setData(client.toMap());
  }









  Future<Client> getClientData(FirebaseUser user) async {
    final db = Firestore.instance;
    DocumentSnapshot documentSnapshot =
    await db.collection('client').document(user.uid).get();

    if(documentSnapshot.exists){
      Service service =
      await ServiceRepository.defaultConstructor().getService(documentSnapshot.data['need']);

      Client client = Client.fromMap(documentSnapshot.data, service,user);
      print("map created");
      return client;
    }
    return null;


  }

  DocumentReference getClientReference (String clientID){
    final dbReference  = Firestore.instance;
    return dbReference.collection("client").document(clientID);
  }

}
