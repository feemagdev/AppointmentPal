import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:meta/meta.dart';

// ignore: must_be_immutable
class Client extends Equatable{

  final String name;
  final String address;
  final String phone;
  FirebaseDatabase firebaseDatabase;
  FirebaseUser user;


  Client({
    @required this.name,
    @required this.address,
    @required this.phone,
    @required this.user});

  @override
  // TODO: implement props
  List<Object> get props => null;

  Map<String, Object> toJson(){
    return{
      'name':name,
      'address':address,
      'phone':phone,
      'uid':user.uid,
    };
  }

  Future<void> registerClient() async{
    firebaseDatabase = FirebaseDatabase.instance;
    return await firebaseDatabase.reference().child('client').push().set(toJson());
  }



}