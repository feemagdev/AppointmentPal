
import 'package:firebase_database/firebase_database.dart';
import 'package:meta/meta.dart';


class Service {
  String key;
  String name;
  String link;

  Service({@required this.key,@required this.name,@required this.link});


   Future<List<Service>> serviceList() async{
    List<Service> servicesList = [];
    DatabaseReference serviceReference =
    FirebaseDatabase.instance.reference();
    await serviceReference.child('service').once().then((DataSnapshot snapshot) {
      var KEYS = snapshot.value.keys;
      var DATA = snapshot.value;
      for(var individualKey in KEYS){
        Service service = new Service(
          key: individualKey,
          name: DATA[individualKey]['name'],
          link: DATA[individualKey]['link'],
        );
        servicesList.add(service);
      }
    });
    return servicesList;
  }


}
