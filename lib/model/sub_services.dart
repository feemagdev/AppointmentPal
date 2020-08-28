
import 'package:cloud_firestore/cloud_firestore.dart';

class SubServices {
  String _subServicesID;
  String _name;
  String _image;

  SubServices(this._subServicesID, this._name, this._image);

  SubServices.defaultConstructor();

  Future<List<SubServices>> getSubServices(String serviceID) async {
    List<SubServices> subServicesList = [];
    final _dbReference = Firestore.instance;
    final String servicePath = 'service';
    final String subServicesPath = 'sub_service';
    final String referenceAttribute = "serviceID";
    DocumentReference documentReference =
        Firestore.instance.collection(servicePath).document(serviceID);
    await _dbReference
        .collection(subServicesPath)
        .where(referenceAttribute, isEqualTo: documentReference)
        .getDocuments()
        .then((snapshot) {
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



  String getSubServiceID(){
    return _subServicesID;
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
