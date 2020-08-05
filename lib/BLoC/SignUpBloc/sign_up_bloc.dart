import 'package:appointmentproject/model/service.dart';
import 'package:appointmentproject/repository/service_repository.dart';

import './bloc.dart';

class SignUpBloc extends Bloc<SignUpEvent,SignUpState>{
  PersonRepository personRepository;
  @override
  // TODO: implement initialState
  SignUpState get initialState => SignUpInitialState();

  @override
  Stream<SignUpState> mapEventToState(SignUpEvent event) async*{
    if(event is SignUpButtonPressedEvent){
      try{
        yield SignUpLoadingState();
        print(event.email);
        personRepository = new PersonRepository(email: event.email, password: event.password);
        var user = await personRepository.registerUser();
        PersonRepository.defaultConstructor().sendVerificationEmail(user);
        yield SignUpSuccessfulState(user: user);
      }catch(e){
        yield SignUpFailureState(message:e.toString());
      }
    }
  }

  Future<List<Service>> getServicesList(){
    ServiceRepository serviceRepository = new ServiceRepository();
    return serviceRepository.getServicesList();
  }

}