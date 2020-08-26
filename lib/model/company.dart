import 'package:cloud_firestore/cloud_firestore.dart';

class Company {
  String _name;
  GeoPoint _companyLocation;

  Company(this._name, this._companyLocation);

  Company.defaultConstructor();


  Company.fromMap(Map snapshot)
      : _name = snapshot['name'],
        _companyLocation = snapshot['location'];



  Future<Company> getCompany(DocumentReference documentReference) async {
    DocumentSnapshot documentSnapshot = await documentReference.get();
    Company company = Company.fromMap(documentSnapshot.data);
    return company;
  }

  GeoPoint get companyLocation => _companyLocation;

  set companyLocation(GeoPoint value) {
    _companyLocation = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }
}
