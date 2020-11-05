import 'package:cloud_firestore/cloud_firestore.dart';

class Professional {
  String _professionalID;
  String _name;
  String _phone;
  String _country;
  String _city;
  String _address;
  Timestamp _dob;
  String _image;
  int _experience;
  String _managerID;

  Professional.defaultConstructor();

  Professional.fromMap(Map snapshot, String professionalID)
      : _professionalID = professionalID,
        _name = snapshot['name'],
        _phone = snapshot['phone'],
        _country = snapshot['country'],
        _city = snapshot['city'],
        _address = snapshot['address'],
        _dob = snapshot['dob'],
        _image = snapshot['image'],
        _experience = snapshot['experience'],
        _managerID = snapshot['managerID'];

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

  String getImage() {
    return _image;
  }

  void setImage(String image) {
    _image = image;
  }

  String getManagerID() {
    return _managerID;
  }

  void setMnanagerID(String managerID) {
    _managerID = managerID;
  }

  int getExperience() {
    return _experience;
  }

  void setExperience(int experience) {
    _experience = experience;
  }

  String getProfessionalID() {
    return _professionalID;
  }

  void setProfessionalID(String professionalID) {
    _professionalID = professionalID;
  }
}
