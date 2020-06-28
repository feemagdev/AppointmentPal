

import 'package:appointmentproject/BLoC/loginBloc/login_event.dart';
import 'package:appointmentproject/BLoC/loginBloc/login_state.dart';
import 'package:appointmentproject/repository/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<LoginEvent,LoginState>{

  UserRepository userRepository;
  FirebaseDatabase firebaseDatabase;
  FirebaseUser user;
  LoginBloc(){
    userRepository = UserRepository();
    firebaseDatabase = FirebaseDatabase.instance;
  }

  @override
  // TODO: implement initialState
  LoginState get initialState => LoginInitialState();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async*{
    if(event is LoginButtonPressed){
          try{
            user = await userRepository.signInUser(event.email, event.password);
            if(await checkProfessionalRole(user)){
              print("check professional true");
              print(user.email);
              yield ProfessionalLoginSuccessState(user: user);
            }
            else if(await checkClientRole(user)){
              print("check client true");
              yield ClientLoginSuccessState(user: user);
            }
          }catch(e){
            yield LoginFailureState(message: e.toString());
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