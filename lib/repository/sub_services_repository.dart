import 'package:appointmentproject/model/sub_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

class SubServiceRepository {
  String name;
  String image;
  String price;

  SubServiceRepository({@required this.name,@required this.image,@required this.price});

  SubServiceRepository.defaultConstructor();


  Future<List<SubServices>> getSubServicesList(String serviceID) async {
    return await SubServices.defaultConstructor().getSubServices(serviceID);
  }

  DocumentReference getSubServicesReference(String subServiceID){
    final dbReference = Firestore.instance;
    return dbReference.collection('sub_service').document(subServiceID);
  }
}
