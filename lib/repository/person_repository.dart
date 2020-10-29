import 'package:appointmentproject/model/person.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

class PersonRepository {
  Person person;
  String email;
  String password;
  PersonRepository({@required this.email,@required this.password});

  PersonRepository.defaultConstructor();

  Future<User> registerUser() async {
    person = new Person(email,password);
    return person.registerUser();
  }

  Future<User> signInUser(String email, String password) async {
    person = new Person(email,password);
    return await person.signInUser();
  }


  Future<void> signOut() async =>await Person.defaultConstructor().signOut();


  Future<User> getCurrentUser() async =>await Person.defaultConstructor().getCurrentUser();


  Future<bool> sendVerificationEmail (User user) async {
    return await Person.defaultConstructor().sendVerificationEmail(user);
  }

  Future<bool> checkUserVerification(User user) async {
    return await Person.defaultConstructor().checkUserVerification(user);
  }

  Future<void> sendPasswordResetMail (String email) async{
    return await Person.defaultConstructor().sendPasswordResetMail(email);
  }

}
