


import 'package:appointmentproject/bloc/AuthBloc/auth_event.dart';
import 'package:appointmentproject/bloc/AuthBloc/auth_state.dart';
import 'package:appointmentproject/repository/person_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class AuthBloc extends Bloc<AuthEvent,AuthState>{



  @override
  AuthState get initialState => AuthInitialState();

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async*{
      if(event is AppStartedEvent){
        await PersonRepository.defaultConstructor().signOut();
        User user;
        try{
          user = await PersonRepository.defaultConstructor().getCurrentUser();
          if(user == null){
            print("un authenticated run");
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

