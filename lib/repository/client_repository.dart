



import 'package:appointmentproject/model/client.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

class ClientRepository {
  String name;
  String address;
  String phone;
  FirebaseUser user;

  // Complete Registration constructor
  ClientRepository({@required this.name,@required this.address,@required this.phone,@required this.user});

  registerClient(){
    Client client = Client(name: name,address: address,phone: phone,user:user);
    client.registerClient();
  }


}
