import 'package:equatable/equatable.dart';

abstract class ProfessionalState extends Equatable {
  const ProfessionalState();
}

class InitialProfessionalState extends ProfessionalState {
  @override
  List<Object> get props => [];
}

class ProfessionalRegisterSuccessfulState extends ProfessionalState {
  @override
  // TODO: implement props
  List<Object> get props => null;
}
