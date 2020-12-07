import 'package:appointmentproject/bloc/UserRoleBloc/bloc.dart';
import 'package:appointmentproject/model/professional.dart';
import 'package:appointmentproject/repository/professional_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserRoleBloc extends Bloc<UserRoleEvent, UserRoleState> {
  @override
  UserRoleState get initialState => InitialUserRoleState();

  @override
  Stream<UserRoleState> mapEventToState(
    UserRoleEvent event,
  ) async* {
    if (event is CheckUserRoleEvent) {
      Professional professional;
      try {
        professional = await getProfessionalData(event.user);
      } catch (e) {
        print(e);
      }
      if (professional != null) {
        yield ProfessionalState(professional: professional);
      }
    }
  }

  Future<Professional> getProfessionalData(User user) async {
    return await ProfessionalRepository.defaultConstructor()
        .getProfessionalData(user.uid);
  }
}
