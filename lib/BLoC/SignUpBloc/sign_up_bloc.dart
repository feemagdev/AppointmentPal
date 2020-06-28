import './bloc.dart';

class SignUpBloc extends Bloc<SignUpEvent,SignUpState>{
  UserRepository userRepository;
  SignUpBloc(){
    userRepository = UserRepository();
  }
  @override
  // TODO: implement initialState
  SignUpState get initialState => SignUpInitialState();

  @override
  Stream<SignUpState> mapEventToState(SignUpEvent event) async*{
    if(event is SignUpButtonPressedEvent){
      try{
        yield SignUpLoadingState();
        print(event.email);
        var user = await userRepository.registerUser(event.email,event.password);
        yield SignUpSuccessfulState(user: user);
      }catch(e){
        yield SignUpFailureState(message:e.toString());
      }
    }
  }

}