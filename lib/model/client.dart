
import 'package:appointmentproject/model/service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Client {
  String _name;
  String _phone;
  String _country;
  String _address;
  String _city;
  Timestamp _dob;
  Service _need;

  FirebaseUser _user;
  final db = Firestore.instance;
  final path = "client";

  Client.register(this._name, this._phone,this._country, this._city, this._address, this._dob,
      this._need,this._user);

  Client.defaultConstructor();



  Client.fromMap(Map snapshot,Service service)
      : _name = snapshot['name'],
        _phone = snapshot['phone'],
        _country = snapshot['country'],
        _city = snapshot['city'],
        _address = snapshot['address'],
        _dob = snapshot['dob'],
        _need = service;

  Map<String, dynamic> toMap([DocumentReference needReference]) {
    return {
      'name': _name,
      'phone': _phone,
      'country':_country,
      'city': _city,
      'address': _address,
      'dob': _dob,
      'need': needReference,
    };
  }

  Future<void> registerClient() async {
    final dbReference = Firestore.instance;
    DocumentReference serviceReference = dbReference.collection('service').document(_need.serviceID);
    await db.collection(path).document(_user.uid).setData(toMap(serviceReference));
  }

  Future<void> updateClient() async {
    await db.collection(path).document(_user.uid).updateData(toMap());
  }

  Future<bool> checkClientDetails(String uid) async {
    DocumentSnapshot data = await db.collection(path).document(uid).get();
    return data.exists;
  }

  Future<Client> getClientData(String uid) async{
    print("in client get data");
    DocumentSnapshot documentSnapshot = await db.collection(path).document(uid).get();
    DocumentReference serviceReference = documentSnapshot.data['need'];
    Service service = await Service.defaultConstructor().getService(serviceReference);
    Client client = Client.fromMap(documentSnapshot.data,service);
    print("map created");
    return  client;
  }

  FirebaseUser get user => _user;

  set user(FirebaseUser value) {
    _user = value;
  }

  Service get need => _need;

  set need(Service value) {
    _need = value;
  }

  Timestamp get dob => _dob;

  set dob(Timestamp value) {
    _dob = value;
  }

  String get city => _city;

  set city(String value) {
    _city = value;
  }

  String get address => _address;

  set address(String value) {
    _address = value;
  }

  String get country => _country;

  set country(String value) {
    _country = value;
  }

  String get phone => _phone;

  set phone(String value) {
    _phone = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

}