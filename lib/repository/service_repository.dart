import 'package:appointmentproject/model/service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ServiceRepository {

  ServiceRepository.defaultConstructor();

  Future<List<Service>> getServicesList(DocumentReference need) async{
    final _dbReference = Firestore.instance;
    final path = "service";
    List<Service> servicesList = List();
    await _dbReference.collection(path).getDocuments().then((snapshot) {
      snapshot.documents.forEach((element) {
        Service service = new Service.fromMap(element.data,element.reference);
        servicesList.add(service);
      });
    });
    if (need != null) {
      for (int index = 0; index < servicesList.length; index++) {
        if (servicesList[index].getServiceID().documentID == need.documentID) {
          Service tempObject = servicesList[0];
          servicesList[0] = servicesList[index];
          servicesList[index] = tempObject;
          break;
        }
      }
    }
    return servicesList;
  }


  DocumentReference getServiceReference(String serviceID){
    final dbReference = Firestore.instance;
    return dbReference.collection('service').document(serviceID);
  }

  Future<Service> getService(DocumentReference serviceReference) async{
    Service service;
    await serviceReference.get().then((value) {
      service = Service.fromMap(value.data,serviceReference);
    });

    return service;

  }


}