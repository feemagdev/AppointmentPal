import 'package:appointmentproject/model/client.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

class ClientRepository {
  String name;
  String phone;
  String country;
  String city;
  String address;
  DateTime dob;
  String need;
  FirebaseUser user;

  // Complete Registration constructor
  ClientRepository(
      {@required this.name,
      @required this.phone,
      @required this.country,
      @required this.city,
      @required this.address,
      @required this.dob,
      @required this.need,
      @required this.user});

  ClientRepository.defaultConstructor();

  registerClient() {
    Client client = Client(name, phone,country, city, address, dob, need, user);
    client.registerClient();
  }

  Future<bool> checkClientDetails(String uid) async {
    return Client.defaultConstructor().checkClientDetails(uid);
  }
}
