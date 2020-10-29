import 'package:cloud_firestore/cloud_firestore.dart';

class Company {
  String _name;
  String _address;
  String _contact;

  Company(this._name, this._address, this._contact);

  Company.defaultConstructor();

  Company.fromMap(Map snapshot)
      : _name = snapshot['name'],
        _address = snapshot['address'],
        _contact = snapshot['address'];

  Future<Company> getCompany(DocumentReference documentReference) async {
    DocumentSnapshot documentSnapshot = await documentReference.get();
    Company company = Company.fromMap(documentSnapshot.data());
    return company;
  }

  String getCompanyAddress() {
    return _address;
  }

  void setCompanyAddress(String address) {
    _address = address;
  }

  String getName() {
    return _name;
  }

  void setName(String name) {
    _name = name;
  }

  String getContact() {
    return _contact;
  }

  void setContact(String contact) {
    _contact = contact;
  }

}
