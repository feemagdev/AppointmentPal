import 'package:appointmentproject/model/company.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Manager {


  String _name;
  String _phone;
  String _city;
  String _address;
  DateTime _dob;
  int _salary;
  Company _company;


  Manager(this._name, this._phone, this._city, this._address, this._dob,
      this._salary, this._company);


  Manager._fromMap(Map snapshot)
      :
    _name = snapshot['name'],
    _phone = snapshot['phone'],
    _city = snapshot['city'],
    _address = snapshot['address'],
    _dob = snapshot['dob'],
    _salary = snapshot['salary'],
    _company = snapshot['companyID'];


  Manager.defaultConstructor();

  Future<Manager> getManager(DocumentReference documentReference) async {
    Manager manager;
    DocumentSnapshot documentSnapshot = await documentReference.get();
    DocumentReference companyReference = documentSnapshot.data['companyID'];
    documentSnapshot.data['companyID'] = await getCompany(companyReference);
    manager = Manager._fromMap(documentSnapshot.data);
    return manager;
  }


  Future<Company> getCompany(DocumentReference documentReference) async {
    return await Company.defaultConstructor().getCompany(documentReference);
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  String get phone => _phone;

  set phone(String value) {
    _phone = value;
  }

  Company get company => _company;

  set company(Company value) {
    _company = value;
  }

  int get salary => _salary;

  set salary(int value) {
    _salary = value;
  }

  DateTime get dob => _dob;

  set dob(DateTime value) {
    _dob = value;
  }

  String get address => _address;

  set address(String value) {
    _address = value;
  }

  String get city => _city;

  set city(String value) {
    _city = value;
  }
}
