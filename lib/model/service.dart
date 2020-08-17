
import 'package:cloud_firestore/cloud_firestore.dart';



class Service {
  String _serviceID;
  String _name;
  String _image;



  Service.defaultConstructor();


  Service(this._serviceID,this._name,this._image);


  String get serviceID => _serviceID;

  set serviceID(String value) {
    _serviceID = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  String get image => _image;

  set image(String value) {
    _image = value;
  }


  Future<List<Service>> getServices(String need) async{
    final _dbReference = Firestore.instance;
    final path = "service";
     List<Service> servicesList= [];
     await _dbReference.collection(path).getDocuments().then((snapshot){
       snapshot.documents.forEach((element) {
         Service service = new Service(element.documentID,element.data['name'],element.data['image']);
         servicesList.add(service);
       });
     });
     if(need != null){
       for(int index = 0 ; index < servicesList.length ; index++){
         if(servicesList[index].name == need){
           Service tempObject =  servicesList[0];
           servicesList[0] = servicesList[index];
           servicesList[index] = tempObject;
           break;
         }
       }
     }
     return servicesList;
  }


}
