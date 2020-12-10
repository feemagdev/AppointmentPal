import 'dart:async';

import 'package:appointmentproject/model/manager.dart';
import 'package:appointmentproject/model/professional.dart';
import 'package:appointmentproject/repository/payment_respository.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

part 'professional_payment_event.dart';
part 'professional_payment_state.dart';

class ProfessionalPaymentBloc
    extends Bloc<ProfessionalPaymentEvent, ProfessionalPaymentState> {
  final Professional professional;
  final Manager manager;
  ProfessionalPaymentBloc({this.professional, this.manager});
  @override
  Stream<ProfessionalPaymentState> mapEventToState(
    ProfessionalPaymentEvent event,
  ) async* {
    if (event is ProfessionalPaymentButtonEvent) {
      if (professional != null) {
        bool check = await PaymentRepository.defualtConstructor()
            .getProfessionalPaymentStatus(professional.getProfessionalID());
        if (check) {
          yield ProfessionalAddPaymentState(amount: event.amount);
        } else {
          yield ProfessionalPaymentAlreadyPaidState();
        }
      } else {
        bool check = await PaymentRepository.defualtConstructor()
            .getManagerPaymentStatus(manager.getManagerID());
        if (check) {
          yield ProfessionalAddPaymentState(amount: event.amount);
        } else {
          yield ProfessionalPaymentAlreadyPaidState();
        }
      }
    }
  }

  @override
  ProfessionalPaymentState get initialState => ProfessionalPaymentInitial();
}
