

import 'package:cloud_firestore/cloud_firestore.dart';

class Service {
  DocumentReference _serviceID;
  String _name;
  String _image;

  Service.defaultConstructor();

  Service.fromMap(Map snapshot,DocumentReference serviceID)
      : _serviceID = serviceID,
        _name = snapshot['name'],
        _image = snapshot['image'];



  DocumentReference getServiceID(){
    return _serviceID;
  }

  String getName(){
    return _name;
  }

  void setName(String name){
    _name = name;
  }

  String getImage(){
    return _image;
  }

  void setImage(String image){
    _image = image;
  }




}
