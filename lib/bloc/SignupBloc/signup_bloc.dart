import 'dart:async';

import 'package:appointmentproject/repository/person_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  @override
  Stream<SignupState> mapEventToState(
    SignupEvent event,
  ) async* {
    if (event is SignUpButtonEvent) {
      yield SignUpLoadingState();
      try {
        User user = await PersonRepository.defaultConstructor()
            .registerUser(event.email, event.password);
        yield SignUpSuccessfulState(user: user);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          yield SignUpFailureState(message: "Weak Password");
        } else if (e.code == 'email-already-in-use') {
          yield SignUpFailureState(message: "Email already in use");
        }
      } catch (e) {
        yield SignUpFailureState(message: "Network error");
      }
    }
  }

  @override
  SignupState get initialState => SignupInitial();
}
