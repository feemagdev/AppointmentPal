


import 'package:appointmentproject/BLoC/homePageBloc/home_page_event.dart';
import 'package:appointmentproject/BLoC/homePageBloc/home_page_state.dart';
import 'package:appointmentproject/repository/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePageBloc extends Bloc<HomePageEvent,HomePageState> {

  UserRepository userRepository;
  HomePageBloc(){
    this.userRepository = UserRepository();
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

