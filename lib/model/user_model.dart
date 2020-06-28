import 'package:firebase_auth/firebase_auth.dart';

class User{
  FirebaseAuth firebaseAuth;

  User(){
    this.firebaseAuth = FirebaseAuth.instance;
  }


  Future<FirebaseUser> registerUser(String email,String password) async{
    try{
      print(email);
      await firebaseAuth.createUserWithEmailAndPassword(email: email,password: password);
      return await firebaseAuth.currentUser();
    }catch(e){
      throw Exception(e.toString());
    }
  }

  Future<FirebaseUser> signInUser(String email,String password) async{
    var result = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password
    );
    return result.user;
  }

  Future<void> signOut() async{
    await firebaseAuth.signOut();
  }

  Future<bool> isSignedIn() async{
    var currentUser = firebaseAuth.currentUser();
    return currentUser != null;
  }

  Future<FirebaseUser> getCurrentUser()async{
    return await firebaseAuth.currentUser();
  }





}