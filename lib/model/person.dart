import 'dart:async';


import 'package:firebase_auth/firebase_auth.dart';
class Person{
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  String _email;
  String _password;

  Person(this._email,this._password);
  Person.defaultConstructor();

  Future<User> registerUser() async{
      await firebaseAuth.createUserWithEmailAndPassword(email: this._email,password: this._password);
      return  firebaseAuth.currentUser;
  }

  Future<User> signInUser() async{
    var result = await firebaseAuth.signInWithEmailAndPassword(
        email: this._email,
        password: this._password
    );
    return result.user;
  }

  Future<void> signOut() async{
    await firebaseAuth.signOut();
  }



  Future<User> getCurrentUser() async {
    User currentUser =  firebaseAuth.currentUser;
    return currentUser;

  }

  Future<bool> sendVerificationEmail (User user) async {
    await user.sendEmailVerification();
    return true;
  }

  Future<bool> checkUserVerification(User user) async {
     return user.emailVerified;
  }

  Future<void> sendPasswordResetMail (String email) async{
    return await firebaseAuth.sendPasswordResetEmail(email: email);
  }





}