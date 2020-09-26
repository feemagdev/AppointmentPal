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
  Service _need;

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
        _need = service,
        _user = user;

  Map<String, dynamic> toMap([DocumentReference needReference]) {
    return {
      'name': _name,
      'phone': _phone,
      'country': _country,
      'city': _city,
      'address': _address,
      'dob': _dob,
      'need': needReference,
    };
  }

  Future<void> registerClient() async {
    final dbReference = Firestore.instance;
    DocumentReference serviceReference =
        dbReference.collection('service').document(_need.getServiceID());
    await db
        .collection(path)
        .document(_user.uid)
        .setData(toMap(serviceReference));
  }

  Future<void> updateClient() async {
    await db.collection(path).document(_user.uid).updateData(toMap());
  }

  Future<bool> checkClientDetails(String uid) async {
    DocumentSnapshot data = await db.collection(path).document(uid).get();
    return data.exists;
  }

  Future<Client> getClientData(FirebaseUser user) async {
    print("in client get data");
    DocumentSnapshot documentSnapshot =
        await db.collection(path).document(user.uid).get();
    DocumentReference serviceReference = documentSnapshot.data['need'];
    Service service =
        await Service.defaultConstructor().getService(serviceReference);

    Client client = Client.fromMap(documentSnapshot.data, service,user);
    print("map created");
    return client;
  }

  FirebaseUser getFirebaseUser() {
    return _user;
  }

  void setFirebaseUser(FirebaseUser user) {
    _user = user;
  }

  Service getNeed() {
    return _need;
  }

  void setNeed(Service need) {
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
