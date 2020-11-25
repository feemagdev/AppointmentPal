import 'package:firebase_auth/firebase_auth.dart';

class PersonRepository {
  PersonRepository.defaultConstructor();

  Future<User> registerUser(String email, String password) async {
    final firebaseAuth = FirebaseAuth.instance;
    UserCredential userCredential = await firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password);
    return userCredential.user;
  }

  Future<User> signInUser(String email, String password) async {
    final firebaseAuth = FirebaseAuth.instance;
    UserCredential user = await firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    return user.user;
  }

  Future<void> signOut() async {
    final firebaseAuth = FirebaseAuth.instance;
    await firebaseAuth.signOut();
  }

  User getCurrentUser() {
    final firebaseAuth = FirebaseAuth.instance;
    User currentUser = firebaseAuth.currentUser;
    return currentUser;
  }

  Future<bool> sendVerificationEmail(User user) async {
    await user.sendEmailVerification();
    return true;
  }

  bool checkUserVerification(User user) {
    return user.emailVerified;
  }

  Future<void> sendPasswordResetMail(String email) async {
    final firebaseAuth = FirebaseAuth.instance;
    return await firebaseAuth.sendPasswordResetEmail(email: email);
  }

  Future<UserCredential> signInUserCredentials(String email,String password)async{
    final firebaseAuth = FirebaseAuth.instance;
    UserCredential userCredential = await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    return userCredential;

  }



}
