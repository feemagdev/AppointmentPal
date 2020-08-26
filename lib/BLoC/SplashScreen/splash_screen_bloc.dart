import 'dart:async';

import 'package:bloc/bloc.dart';

part 'splash_screen_event.dart';
part 'splash_screen_state.dart';

class SplashScreenBloc extends Bloc<SplashScreenEvent, SplashScreenState> {

  @override
  SplashScreenState get initialState => SplashScreenInitial();


  @override
  Stream<SplashScreenState> mapEventToState(
    SplashScreenEvent event,
  ) async* {
   if(event is SplashScreenStartEvent){
     yield SplashScreenStartState();
   }

   if(event is SplashScreenEndedEvent){
     yield SplashScreenEndedState();
   }
  }


}
