import 'package:appointmentproject/model/sub_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

class SubServiceRepository {
  String name;
  String image;
  String price;

  SubServiceRepository({@required this.name,@required this.image,@required this.price});

  SubServiceRepository.defaultConstructor();


  Future<List<SubServices>> getSubServicesList(DocumentReference serviceID) async {
    List<SubServices> subServicesList = List();
    final _dbReference = Firestore.instance;
    final String servicePath = 'service';
    final String subServicesPath = 'sub_service';
    final String referenceAttribute = "serviceID";
    await _dbReference
        .collection(subServicesPath)
        .where(referenceAttribute, isEqualTo: serviceID)
        .getDocuments()
        .then((snapshot) {
      snapshot.documents.forEach((element) {
        SubServices subServices = new SubServices(
            element.reference, element.data['name'], element.data['image']);
        subServicesList.add(subServices);
      });
    });
    return subServicesList;
  }

  DocumentReference getSubServicesReference(String subServiceID){
    final dbReference = Firestore.instance;
    return dbReference.collection('sub_service').document(subServiceID);
  }

  Future<SubServices> getSubService(DocumentReference documentReference) async {
    SubServices service;
    await documentReference.get().then((value) {
      service = SubServices.fromMap(value.data, value.reference);
    });


    return service;
  }




}
