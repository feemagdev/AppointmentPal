import 'package:appointmentproject/bloc/ProfessionalBloc/PaymentPageBloc/payment_page_bloc.dart';
import 'package:appointmentproject/model/manager.dart';
import 'package:appointmentproject/model/professional.dart';
import 'package:appointmentproject/ui/Professional/PayPalWebView/components/paypal_web_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaypalWebViewScreen extends StatelessWidget {
  final Professional professional;
  final int amount;
  final Manager manager;
  PaypalWebViewScreen({this.professional, @required this.amount, this.manager});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PaymentPageBloc(
          professional: professional, amount: amount, manager: manager),
      child: PaymentPage(),
    );
  }
}
