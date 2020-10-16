import 'package:cloud_firestore/cloud_firestore.dart';

class Customer {
  DocumentReference _customerID;
  String _name;
  String _phone;

  Map<String, dynamic> toMap(String name, String phone) {
    return {
      'name': name,
      'phone': phone,
    };
  }

  Customer.fromMap(Map snapshot, DocumentReference customerID)
      : _name = snapshot['name'],
        _phone = snapshot['phone'],
        _customerID = customerID;


  DocumentReference getCustomerID(){
    return _customerID;
  }

  String getName(){
    return _name;
  }

  String getPhone(){
    return _phone;
  }



}


