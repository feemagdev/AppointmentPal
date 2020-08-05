
import 'package:cloud_firestore/cloud_firestore.dart';



class Service {
  String _name;
  String _image;


  Service.defaultConstructor();


  Service(this._name,this._image);


  String get name => _name;

  set name(String value) {
    _name = value;
  }

  String get image => _image;

  set image(String value) {
    _image = value;
  }

 /* Future<List<Service>> serviceList() async{
    List<Service> servicesList = [];
    DatabaseReference serviceReference =
    FirebaseDatabase.instance.reference();
    await serviceReference.child('service').once().then((DataSnapshot snapshot) {
      var KEYS = snapshot.value.keys;
      var DATA = snapshot.value;
      for(var individualKey in KEYS){
        Service service = new Service(
          _name: DATA[individualKey]['name'],
          image: DATA[individualKey]['link'],
        );
        servicesList.add(service);
      }
    });
    return servicesList;
  }  */

  Future<List<Service>> getServices() async{
    final _dbReference = Firestore.instance;
    final path = "service";
     List<Service> servicesList= [];
     await _dbReference.collection(path).getDocuments().then((snapshot){
       snapshot.documents.forEach((element) {
         var name = element.documentID;
         element.data.forEach((key, value) {
           var image = value;
           Service service = new Service(name,image);
           servicesList.add(service);
         });
       });
     });
     print(servicesList[0].name);
     print(servicesList[0].image);
     return servicesList;
  }


}
