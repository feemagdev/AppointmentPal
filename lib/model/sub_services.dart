import 'package:firebase_database/firebase_database.dart';
import 'package:meta/meta.dart';


class SubServices {
  String key;
  String name;
  String link;

  SubServices({@required this.key, @required this.name, @required this.link});


  Future<List<SubServices>> fetchSubServices(String serviceID) async {
    List<SubServices> subServicesList = [];
    Query query = FirebaseDatabase.instance.reference().child("sub_services").orderByChild("serviceid");
    await query.equalTo(serviceID).once().then((snapshot){
      print(snapshot.value);
      var DATA = snapshot.value;
      var KEYS = snapshot.value.keys;

      for(var individualKey in KEYS){
        SubServices subServices = new SubServices(key: individualKey, name: DATA[individualKey]['name'], link: DATA[individualKey]['link']);
        subServicesList.add(subServices);
      }
    });
    return subServicesList;
  }


}