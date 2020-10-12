import 'package:appointmentproject/model/person.dart';
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
  DocumentReference _need;

  FirebaseUser _user;
  final db = Firestore.instance;
  final path = "client";

  Client.register(this._name, this._phone, this._country, this._city,
      this._address, this._dob, this._need, this._user);

  Client.defaultConstructor();

  Client.fromMap(Map snapshot, Service service, FirebaseUser user)
      : _name = snapshot['name'],
        _phone = snapshot['phone'],
        _country = snapshot['country'],
        _city = snapshot['city'],
        _address = snapshot['address'],
        _dob = snapshot['dob'],
        _need = snapshot['need'],
        _user = user;

  Map<String, dynamic> toMap() {
    return {
      'name': _name,
      'phone': _phone,
      'country': _country,
      'city': _city,
      'address': _address,
      'dob': _dob,
      'need': _need,
    };
  }

  FirebaseUser getFirebaseUser() {
    return _user;
  }

  void setFirebaseUser(FirebaseUser user) {
    _user = user;
  }

  DocumentReference getNeed() {
    return _need;
  }

  void setNeed(DocumentReference need) {
    _need = need;
  }

  Timestamp getDob() {
    return _dob;
  }

  void setDob(Timestamp dob) {
    _dob = dob;
  }

  String getCity() {
    return _city;
  }

  void setCity(String city) {
    _city = city;
  }

  String getCountry() {
    return _country;
  }

  void setCountry(String country) {
    _country = country;
  }

  String getAddress() {
    return _address;
  }

  void setAddress(String address) {
    _address = address;
  }

  String getPhone() {
    return _phone;
  }

  void setPhone(String phone) {
    _address = phone;
  }

  String getName() {
    return _name;
  }

  void setName(String name) {
    _name = name;
  }
}
