import 'package:appointmentproject/model/company.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Manager {
  String _name;
  String _phone;
  String _country;
  String _city;
  String _address;
  Timestamp _dob;
  int _salary;
  Company _company;

  Manager(this._name, this._phone, this._country, this._city, this._address,
      this._dob, this._salary, this._company);

  Manager._fromMap(Map snapshot)
      : _name = snapshot['name'],
        _phone = snapshot['phone'],
        _country = snapshot['country'],
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
    documentSnapshot.data['companyID'] = await getCompanyByReference(companyReference);
    manager = Manager._fromMap(documentSnapshot.data);
    return manager;
  }

  Future<Company> getCompanyByReference(DocumentReference documentReference) async {
    return await Company.defaultConstructor().getCompany(documentReference);
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

  int getSalary() {
    return _salary;
  }

  void setSalary(int salary) {
    _salary = salary;
  }

  Company getCompany() {
    return _company;
  }

  void setCompany(Company company){
    _company = company;
  }
}
