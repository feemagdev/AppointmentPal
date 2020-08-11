


import 'package:appointmentproject/BLoC/homePageBloc/home_page_event.dart';
import 'package:appointmentproject/BLoC/homePageBloc/home_page_state.dart';
import 'package:appointmentproject/repository/person_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePageBloc extends Bloc<HomePageEvent,HomePageState> {

  PersonRepository userRepository;
  HomePageBloc(){
    this.userRepository = PersonRepository();
  }

  @override
  // TODO: implement initialState
  HomePageState get initialState => LogOutInitialState();

  @override
  Stream<HomePageState> mapEventToState(HomePageEvent event) async*{
    if(event is LogOutButtonPressed){
        await userRepository.signOut();
        yield LogOutSuccessState();
    }
  }
}

