import 'dart:async';

import 'package:appointmentproject/model/customer.dart';
import 'package:appointmentproject/model/professional.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'customer_detail_event.dart';
part 'customer_detail_state.dart';

class CustomerDetailBloc
    extends Bloc<CustomerDetailEvent, CustomerDetailState> {
  final Customer customer;
  final Professional professional;
  CustomerDetailBloc({@required this.customer, @required this.professional});
  @override
  Stream<CustomerDetailState> mapEventToState(
    CustomerDetailEvent event,
  ) async* {}

  @override
  CustomerDetailState get initialState => CustomerDetailInitial();
}
