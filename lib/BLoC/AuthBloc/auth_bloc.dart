import 'package:appointmentproject/repository/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent,AuthState>{

  UserRepository userRepository;
  AuthBloc(){
    userRepository = UserRepository();
  }

  @override
  // TODO: implement initialState
  AuthState get initialState => AuthInitialState();

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async*{
    try{
      if(event is AppStartedEvent){
        print("App Started Event");

        var isSignedIn = await userRepository.isSignedIn();
        print(isSignedIn);
        if(isSignedIn){
          userRepository.signOut();
          print("isSignedIn Run");
          var user = await userRepository.getCurrentUser();
          print(user.email);


          yield AuthenticatedState(user:user);
        }else{
          yield UnAuthenticatedState();
        }
      }
    }catch(e){
      yield UnAuthenticatedState();
    }
  }

}

