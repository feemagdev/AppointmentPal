import 'package:appointmentproject/model/client.dart';
import 'package:appointmentproject/model/service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

class ClientRepository {
  String name;
  String phone;
  String country;
  String city;
  String address;
  Timestamp dob;
  Service need;
  FirebaseUser user;

  // Complete Registration constructor
  ClientRepository(
      {@required this.name,
      @required this.phone,
      @required this.country,
      @required this.city,
      @required this.address,
      @required this.dob,
      @required this.need,
      @required this.user});

  ClientRepository.defaultConstructor();

  registerClient() {
    Client client =
        Client.register(name, phone, country, city, address, dob, need, user);
    client.registerClient();
  }

  ClientRepository.fromMap(Map snapshot)
      : name = snapshot['name'],
        phone = snapshot['phone'],
        country = snapshot['country'],
        dob = snapshot['dob'],
        need = snapshot['need'];

  Future<bool> checkClientDetails(String uid) async {
    return Client.defaultConstructor().checkClientDetails(uid);
  }

  Future<Client> getClientData(FirebaseUser user) async {
    return  await Client.defaultConstructor().getClientData(user);
  }

  DocumentReference getClientReference (String clientID){
    final dbReference  = Firestore.instance;
    return dbReference.collection("client").document(clientID);
  }

}
