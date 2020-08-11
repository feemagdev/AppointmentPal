import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Client {
  var _name, _phone,_country,_city, _address, _dob, _need;
  FirebaseUser _user;
  final db = Firestore.instance;
  final path = "client";

  Client.register(this._name, this._phone,this._country, this._city, this._address, this._dob,
      this._need,this._user);

  Client.defaultConstructor();



  Client.fromMap(Map snapshot)
      : _name = snapshot['name'],
        _phone = snapshot['phone'],
        _country = snapshot['country'],
        _city = snapshot['city'],
        _address = snapshot['address'],
        _dob = snapshot['dob'],
        _need = snapshot['need'];

  Map<String, dynamic> toMap() {
    return {
      'name': _name,
      'phone': _phone,
      'country':_country,
      'city': _city,
      'address': _address,
      'dob': _dob,
      'need': _need,
    };
  }

  Future<void> registerClient() async {
    await db.collection(path).document(_user.uid).setData(toMap());
  }

  Future<void> updateClient() async {
    await db.collection(path).document(_user.uid).updateData(toMap());
  }

  Future<bool> checkClientDetails(String uid) async {
    DocumentSnapshot data = await db.collection(path).document(uid).get();
    return data.exists;
  }

  Future<Client> getClientData(String uid) async{
    DocumentSnapshot documentSnapshot = await db.collection(path).document(uid).get();
    Client client = Client.fromMap(documentSnapshot.data);
    return  client;
  }

  get need => _need;

  set need(value) {
    _need = value;
  }

  get dob => _dob;

  set dob(value) {
    _dob = value;
  }

  get address => _address;

  set address(value) {
    _address = value;
  }

  get city => _city;

  set city(value) {
    _city = value;
  }

  get country => _country;

  set country(value) {
    _country = value;
  }

  get phone => _phone;

  set phone(value) {
    _phone = value;
  }

  get name => _name;

  set name(value) {
    _name = value;
  }
}