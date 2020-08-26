

import 'package:appointmentproject/repository/person_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent,AuthState>{



  @override
  // TODO: implement initialState
  AuthState get initialState => AuthInitialState();

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async*{
    try{
      if(event is AppStartedEvent){
        print("App Started Event");
        PersonRepository.defaultConstructor().signOut();
        var isSignedIn = await PersonRepository.defaultConstructor().isSignedIn();
        print(isSignedIn);
        if(isSignedIn){
          print("isSignedIn Run");
          //PersonRepository.defaultConstructor().signOut();
          var user = await PersonRepository.defaultConstructor().getCurrentUser();
          if(user.uid == null){
            yield UnAuthenticatedState();
          }
          else{
            yield AuthenticatedState(user:user);
          }

        }else{
          yield UnAuthenticatedState();
        }
      }
    }catch(e){
      print(e);
      yield UnAuthenticatedState();
    }
  }

}

