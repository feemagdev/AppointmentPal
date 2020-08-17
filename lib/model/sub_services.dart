import 'package:cloud_firestore/cloud_firestore.dart';

class SubServices {
  String _name;
  String _image;
  int _price;

  SubServices(this._name, this._image, this._price);

  SubServices.defaultConstructor();


  Future<List<SubServices>> getSubServices(String serviceID) async {
    print("in get sub services function");
    List<SubServices> subServicesList = [];
    final _dbReference = Firestore.instance;
    final String servicePath = 'service';
    final String subServicesPath = 'sub_service';
    print(Firestore.instance.collection(servicePath).document(serviceID).path);
    final String referenceAttribute = "serviceID";
    DocumentReference documentReference =  Firestore.instance.collection(servicePath).document(serviceID);
    await _dbReference.collection(subServicesPath).where(referenceAttribute,isEqualTo: documentReference)
        .getDocuments()
        .then((snapshot) {
         print( snapshot.documents.length);
      snapshot.documents.forEach((element) {
        SubServices subServices = new SubServices(element.data['name'], element.data['image'], element.data['price']);
        subServicesList.add(subServices);
      });
    });

    return subServicesList;
  }







  int get price => _price;

  set price(int value) {
    _price = value;
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
