import 'package:cloud_firestore/cloud_firestore.dart';

class SubServices {
  DocumentReference _subServicesID;
  String _name;
  String _image;
  DocumentReference _serviceID;

  SubServices(this._subServicesID, this._name, this._image);

  SubServices.defaultConstructor();

  SubServices.fromMap(
      Map<String, dynamic> snapshot, DocumentReference subServicesID)
      : _subServicesID = subServicesID,
        _name = snapshot['name'],
        _image = snapshot['image'],
        _serviceID = snapshot['serviceID'];



  DocumentReference getSubServiceID() {
    return _subServicesID;
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

  DocumentReference getServiceID() {
    return _serviceID;
  }
}
