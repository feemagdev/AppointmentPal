import 'package:appointmentproject/model/service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SubServices {
  String _subServicesID;
  String _name;
  String _image;

  SubServices(this._subServicesID, this._name, this._image);

  SubServices.defaultConstructor();

  Future<List<SubServices>> getSubServices(String serviceID) async {
    print("in get sub services function");
    List<SubServices> subServicesList = [];
    final _dbReference = Firestore.instance;
    final String servicePath = 'service';
    final String subServicesPath = 'sub_service';
    print(Firestore.instance.collection(servicePath).document(serviceID).path);
    final String referenceAttribute = "serviceID";
    DocumentReference documentReference =
        Firestore.instance.collection(servicePath).document(serviceID);
    await _dbReference
        .collection(subServicesPath)
        .where(referenceAttribute, isEqualTo: documentReference)
        .getDocuments()
        .then((snapshot) {
      print(snapshot.documents.length);
      snapshot.documents.forEach((element) {
        SubServices subServices = new SubServices(
            element.documentID, element.data['name'], element.data['image']);
        subServicesList.add(subServices);
      });
    });

    return subServicesList;
  }

  Future<SubServices> getSubService(DocumentReference documentReference) async {
    DocumentSnapshot documentSnapshot = await documentReference.get();
    SubServices service = SubServices(documentSnapshot.documentID,
        documentSnapshot.data['name'], documentSnapshot.data['image']);
    return service;
  }

  DocumentReference getSubServiceReference (String subServiceID) {
    final dbRef = Firestore.instance;
    return  dbRef.collection('sub_service').document(subServiceID);
  }




  String get subServicesID => _subServicesID;

  set subServicesID(String value) {
    _subServicesID = value;
  }

  String get image => _image;

  set image(String value) {
    _image = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }
}
