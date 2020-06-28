import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class ClientDashboardBloc extends Bloc<ClientDashboardEvent, ClientDashboardState> {
  @override
  ClientDashboardState get initialState => InitialClientDashboardState();

  @override
  Stream<ClientDashboardState> mapEventToState(
    ClientDashboardEvent event,
  ) async* {

    if(event is SearchBarOnTapEvent){
      yield MoveToSearchScreenState();
    }


    // TODO: Add Logic
  }
}
