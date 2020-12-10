import 'package:appointmentproject/bloc/ProfessionalBloc/CustomerDetailBloc/customer_detail_bloc.dart';
import 'package:appointmentproject/model/customer.dart';
import 'package:appointmentproject/model/professional.dart';
import 'package:appointmentproject/ui/Professional/CustomerDetailScreen/components/customer_detail_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomerDetailScreen extends StatelessWidget {
  final Customer customer;
  final Professional professional;
  CustomerDetailScreen({@required this.customer, @required this.professional});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CustomerDetailBloc(customer: customer, professional: professional),
      child: CustomerDetailBody(),
    );
  }
}
