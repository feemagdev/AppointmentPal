import 'package:cloud_firestore/cloud_firestore.dart';

class Service {
  String _serviceID;
  String _name;
  String _image;

  Service.defaultConstructor();

  Service(this._serviceID, this._name, this._image);

  Service.fromMap(Map snapshot)
      : _serviceID = snapshot['serviceID'],
        _name = snapshot['name'],
        _image = snapshot['image'];

  Future<List<Service>> getServices(String need) async {
    final _dbReference = Firestore.instance;
    final path = "service";
    List<Service> servicesList = [];
    await _dbReference.collection(path).getDocuments().then((snapshot) {
      snapshot.documents.forEach((element) {
        Service service = new Service(
            element.documentID, element.data['name'], element.data['image']);
        servicesList.add(service);
      });
    });
    if (need != null) {
      for (int index = 0; index < servicesList.length; index++) {
        if (servicesList[index].getName() == need) {
          Service tempObject = servicesList[0];
          servicesList[0] = servicesList[index];
          servicesList[index] = tempObject;
          break;
        }
      }
    }
    return servicesList;
  }


  Future<Service> getService(DocumentReference reference) async {
    DocumentReference serviceReference = reference;
    DocumentSnapshot documentSnapshot = await serviceReference.get();
    Service service = Service(documentSnapshot.documentID, documentSnapshot.data['name'], documentSnapshot.data['image']);
    return service;

  }

  String getServiceID(){
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
