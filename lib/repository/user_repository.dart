import 'package:appointmentproject/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserRepository {
  User user;

  UserRepository() {
    this.user = User();
  }

  Future<FirebaseUser> registerUser(String email, String password) async =>
      user.registerUser(email, password);

  Future<FirebaseUser> signInUser(String email, String password) async =>
      user.signInUser(email, password);

  Future<void> signOut() async => user.signOut();

  Future<bool> isSignedIn() async => user.isSignedIn();

  Future<FirebaseUser> getCurrentUser() async => user.getCurrentUser();

}