import 'dart:async';
import 'package:appointmentproject/BLoC/signUpBloc/bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import './bloc.dart';

class UserRoleBloc extends Bloc<UserRoleEvent, UserRoleState> {
  FirebaseDatabase firebaseDatabase;
  UserRepository userRepository;
  @override
  UserRoleState get initialState => InitialUserRoleState();

  UserRoleBloc(){
    firebaseDatabase = FirebaseDatabase.instance;
    userRepository = UserRepository();
  }

  @override
  Stream<UserRoleState> mapEventToState(
    UserRoleEvent event,
  ) async* {
    print("in check user role async");
    if(event is CheckUserRoleEvent){

      FirebaseUser user = await userRepository.getCurrentUser();
      print("in check user role event");
      print(user.email);

      if(await checkProfessionalRole(user)){
        print("check professional true");
        yield ProfessionalState(user: user);
      }
      else if(await checkClientRole(user)){
        print("check client true");
        yield ClientState(user: user);
      }
    }


  }



  Future<bool> checkProfessionalRole(FirebaseUser user) async {
    Query query = firebaseDatabase.reference().child('professional').orderByChild('uid').equalTo(user.uid);
    Future<bool> check = query.once().then((snapshot){
      return (snapshot.value != null);
    });
    return await check;

  }

  Future<bool> checkClientRole(FirebaseUser user) async {
    Query query = firebaseDatabase.reference().child('client').orderByChild('uid').equalTo(user.uid);
    Future<bool> check = query.once().then((snapshot){
      return (snapshot.value != null);
    });
    return await check;
  }




}
