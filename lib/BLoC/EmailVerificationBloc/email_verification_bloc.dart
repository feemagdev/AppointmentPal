import 'dart:async';

import 'package:appointmentproject/BLoC/SignUpBloc/bloc.dart';
import 'package:appointmentproject/model/service.dart';
import 'package:appointmentproject/repository/service_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';

part 'email_verification_event.dart';
part 'email_verification_state.dart';

class EmailVerificationBloc extends Bloc<EmailVerificationEvent, EmailVerificationState> {

  @override
  EmailVerificationState get initialState => EmailVerificationInitial();

  @override
  Stream<EmailVerificationState> mapEventToState(
    EmailVerificationEvent event,
  ) async* {
    if(event is SendEmailVerificationEvent){
      try{
        await PersonRepository.defaultConstructor().sendVerificationEmail(event.user);
        yield VerificationEmailSent();
      }
      catch(e){
        if(e is PlatformException){
          if(e.code ==  "ERROR_TOO_MANY_REQUESTS"){
            yield VerificationSentFailedState(errorMessage:"TOO MANY REQUESTS PLEASE TRY AGAIN LATER");
          }
        }
      }

    }
    if(event is CheckEmailVerification){
      await  event.user.reload();
      FirebaseUser user = await PersonRepository.defaultConstructor().getCurrentUser();
      bool check = await PersonRepository.defaultConstructor().checkUserVerification(user);
      if(check){
        yield EmailVerified(user: event.user, services: await getServicesList());
      }
      else{
        yield EmailNotVerified();
      }
    }
  }

  Future<List<Service>> getServicesList() async{
    return await ServiceRepository.defaultConstructor().getServicesList(null);
  }

}
