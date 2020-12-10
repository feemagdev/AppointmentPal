import 'dart:async';

import 'package:appointmentproject/model/manager.dart';
import 'package:appointmentproject/model/payment.dart';
import 'package:appointmentproject/model/professional.dart';
import 'package:appointmentproject/repository/payment_respository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'payment_page_event.dart';
part 'payment_page_state.dart';

class PaymentPageBloc extends Bloc<PaymentPageEvent, PaymentPageState> {
  final Professional professional;
  final int amount;
  final Manager manager;
  PaymentPageBloc({this.professional, @required this.amount, this.manager});

  @override
  Stream<PaymentPageState> mapEventToState(
    PaymentPageEvent event,
  ) async* {
    if (event is PaymentSuccessEvent) {
    } else if (event is ProfessionalPaymentSuccessEvent) {
      yield PaymentPageLoadingState();
      if (professional != null) {
        bool check = await PaymentRepository.defualtConstructor()
            .professionalCreatePayment(
                event.payment, professional.getProfessionalID());
        if (check) {
          yield ProfessionalPaymentSuccessState();
        }
      } else {
        bool check = await PaymentRepository.defualtConstructor()
            .managerCreatePayment(event.payment, manager.getManagerID());
        if (check) {
          yield ManagerPaymentSuccessState();
        }
      }
    } else if (event is ProfessionalPaymentFailureEvent) {
      yield ProfessionalPaymentFailureState();
    }
  }

  @override
  PaymentPageState get initialState => PaymentPageInitial();
}
