import './bloc.dart';

class ProfessionalBloc extends Bloc<ProfessionalEvent, ProfessionalState> {

//  Professional professional;
 // ProfessionalRepository professionalRepository;

  @override
  ProfessionalState get initialState => InitialProfessionalState();

  @override
  Stream<ProfessionalState> mapEventToState(ProfessionalEvent event) async* {
    if (event is CompleteRegistration) {

    }
  }


}
