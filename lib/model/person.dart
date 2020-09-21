import 'dart:async';


import 'package:firebase_auth/firebase_auth.dart';
class Person{
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  String _email;
  String _password;

  Person(this._email,this._password);
  Person.defaultConstructor();

  Future<FirebaseUser> registerUser() async{
      await firebaseAuth.createUserWithEmailAndPassword(email: this._email,password: this._password);
      return await firebaseAuth.currentUser();
  }

  Future<FirebaseUser> signInUser() async{
    var result = await firebaseAuth.signInWithEmailAndPassword(
        email: this._email,
        password: this._password
    );
    return result.user;
  }

  Future<void> signOut() async{
    await firebaseAuth.signOut();
  }



  Future<FirebaseUser> getCurrentUser() async {
    FirebaseUser currentUser = await firebaseAuth.currentUser();
    return currentUser;

  }

  Future<bool> sendVerificationEmail (FirebaseUser user) async {
    await user.sendEmailVerification();
    return true;
  }

  Future<bool> checkUserVerification(FirebaseUser user) async {
     return user.isEmailVerified;
  }

  Future<void> sendPasswordResetMail (String email) async{
    return await firebaseAuth.sendPasswordResetEmail(email: email);
  }





}