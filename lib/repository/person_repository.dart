import 'package:appointmentproject/model/person.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

class PersonRepository {
  Person person;
  String email;
  String password;
  PersonRepository({@required this.email,@required this.password});

  PersonRepository.defaultConstructor();

  Future<FirebaseUser> registerUser() async {
    person = new Person(email,password);
    return person.registerUser();
  }

  Future<FirebaseUser> signInUser(String email, String password) {
    person = new Person(email,password);
    return person.signInUser();
  }


  Future<void> signOut() async =>await Person.defaultConstructor().signOut();

  Future<bool> isSignedIn() async => await Person.defaultConstructor().isSignedIn();

  Future<FirebaseUser> getCurrentUser() async =>await Person.defaultConstructor().getCurrentUser();


  Future<bool> sendVerificationEmail (FirebaseUser user) async {
    return await Person.defaultConstructor().sendVerificationEmail(user);
  }

  Future<bool> checkUserVerification(FirebaseUser user) async {
    return await Person.defaultConstructor().checkUserVerification(user);
  }

}
