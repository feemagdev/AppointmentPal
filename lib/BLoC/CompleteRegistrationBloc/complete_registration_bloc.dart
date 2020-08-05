import 'dart:async';
import 'package:appointmentproject/BLoC/SignUpBloc/bloc.dart';
import 'package:appointmentproject/repository/client_repository.dart';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class CompleteRegistrationBloc
    extends Bloc<CompleteRegistrationBlocEvent, CompleteRegistrationBlocState> {
  ClientRepository clientRepository;

  @override
  CompleteRegistrationBlocState get initialState =>
      InitialCompleteRegistrationBlocState();

  @override
  Stream<CompleteRegistrationBlocState> mapEventToState(
    CompleteRegistrationBlocEvent event,
  ) async* {
    if (event is CompleteRegistrationButtonPressedEvent) {
      try {
        clientRepository = new ClientRepository(
            name: event.name,
            phone: event.phone,
            country: event.country,
            city: event.city,
            address: event.address,
            dob: event.dob,
            need: event.need,
            user: event.user);
        clientRepository.registerClient();
        yield SuccessfulCompleteRegistrationBlocState(user: event.user);
      } catch (Exception) {
        print("user not registered completely " + Exception);
        yield FailureCompleteRegistrationBlocState(
            message: Exception.toString());
      }
    }

    if(event is DatePickerEvent){
      yield DatePickerState(dateTime: event.dateTime);
    }

    // TODO: Add Logic
  }
}
