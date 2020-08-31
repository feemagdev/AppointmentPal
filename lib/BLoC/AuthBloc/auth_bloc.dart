

import 'package:appointmentproject/repository/person_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent,AuthState>{



  @override
  AuthState get initialState => AuthInitialState();

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async*{
      if(event is AppStartedEvent){
        PersonRepository.defaultConstructor().signOut();
        FirebaseUser user;
        try{
          user = await PersonRepository.defaultConstructor().getCurrentUser();
          if(user == null){
            yield UnAuthenticatedState();
          }
          else{



            yield AuthenticatedState(user: user);
          }
        }catch(exception){

          UnAuthenticatedState();
        }
      }


  }

}

