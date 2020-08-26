
import 'package:appointmentproject/model/manager.dart';
import 'package:appointmentproject/model/service.dart';
import 'package:appointmentproject/model/sub_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Professional {
  String _uid;
  String _name;
  String _phone;
  String _image;
  Timestamp _dob;
  int _appointmentCharges;
  int _experience;
  SubServices _subServices;
  String _address;
  GeoPoint _appointmentLocation;

  Professional.defaultConstructor();

  Professional.fromMap(Map snapshot, SubServices subServices)
      : _uid = snapshot['professionalUID'],
        _name = snapshot['name'],
        _phone = snapshot['phone'],
        _image = snapshot['image'],
        _dob = snapshot['dob'],
        _appointmentCharges = snapshot['appointmentCharges'],
        _experience = snapshot['experience'],
        _subServices = subServices,
        _address = snapshot['address'],
        _appointmentLocation = snapshot['appointmentLocation'];

  Future<List<Professional>> getListOfProfessionalsBySubService(
      String subServiceID) async {
    List<Professional> listOfProfessionals = [];
    final dbReference = Firestore.instance;
    DocumentReference subServiceReference =
        getSubServiceReference(subServiceID);
    SubServices subServices = await SubServices.defaultConstructor()
        .getSubService(subServiceReference);
    await dbReference
        .collection('professional')
        .where('sub_serviceID', isEqualTo: subServiceReference)
        .getDocuments()
        .then((value) {
      value.documents.forEach((element) async {
        Professional professional =
            Professional.fromMap(element.data, subServices);
        listOfProfessionals.add(professional);
      });
    });
    print("length of professionals" + listOfProfessionals.length.toString());
    return listOfProfessionals;
  }

  Future<Manager> getManager(DocumentReference documentReference) async {
    return await Manager.defaultConstructor().getManager(documentReference);
  }

  Future<Service> getService(DocumentReference documentReference) async {
    //  return await Service.defaultConstructor().getService(documentReference);
  }

  Future<SubServices> getSubService(DocumentReference documentReference) async {
    return await SubServices.defaultConstructor()
        .getSubService(documentReference);
  }

  DocumentReference getSubServiceReference(String subServiceID) {
    return SubServices.defaultConstructor()
        .getSubServiceReference(subServiceID);
  }

  int get appointmentCharges => _appointmentCharges;

  set appointmentCharges(int value) {
    _appointmentCharges = value;
  }

  Timestamp get dob => _dob;

  set dob(Timestamp value) {
    _dob = value;
  }

  String get image => _image;

  set image(String value) {
    _image = value;
  }

  String get phone => _phone;

  set phone(String value) {
    _phone = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  String get uid => _uid;

  set uid(String value) {
    _uid = value;
  }

  int get experience => _experience;

  set experience(int value) {
    _experience = value;
  }

  SubServices get subServices => _subServices;

  set subServices(SubServices value) {
    _subServices = value;
  }

  String get address => _address;

  set address(String value) {
    _address = value;
  }

  GeoPoint get appointmentLocation => _appointmentLocation;

  set appointmentLocation(GeoPoint value) {
    _appointmentLocation = value;
  }
}
