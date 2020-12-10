import 'dart:io';

import 'package:appointmentproject/bloc/ProfessionalBloc/PaymentPageBloc/payment_page_bloc.dart';
import 'package:appointmentproject/model/manager.dart';
import 'package:appointmentproject/model/payment.dart';
import 'package:appointmentproject/model/professional.dart';
import 'package:appointmentproject/ui/Manager/ManagerDashboard/manager_dashboard_screen.dart';
import 'package:appointmentproject/ui/Professional/ProfessionalDashboard/professional_dashboard_screen.dart';
import 'package:appointmentproject/ui/Professional/ProfessionalPaymentScreen/professional_payment_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentPage extends StatefulWidget {
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  int _amount = 0;
  Manager _manager;
  Professional _professional;
  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    _amount = BlocProvider.of<PaymentPageBloc>(context).amount;
    _manager = BlocProvider.of<PaymentPageBloc>(context).manager;
    _professional = BlocProvider.of<PaymentPageBloc>(context).professional;
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            BlocListener<PaymentPageBloc, PaymentPageState>(
              listener: (context, state) {
                if (state is ProfessionalPaymentSuccessState) {
                  successfulDialog();
                } else if (state is ProfessionalPaymentFailureState) {
                  errorDialog();
                } else if (state is ManagerPaymentSuccessState) {
                  successfulDialog();
                }
              },
              child: BlocBuilder<PaymentPageBloc, PaymentPageState>(
                  builder: (context, state) {
                if (state is PaymentPageInitial) {
                  return webviewBuilder();
                } else if (state is PaymentPageLoadingState) {
                  return Center(child: CircularProgressIndicator());
                }
                return Container();
              }),
            )
          ],
        ),
      ),
    );
  }

  Widget webviewBuilder() {
    return WebView(
      onPageFinished: (page) {
        if (page.contains('/success')) {
          Professional professional =
              BlocProvider.of<PaymentPageBloc>(context).professional;
          if (professional != null) {
            Payment payment = Payment.defaultConstructor();
            payment.setAmount(_amount);
            payment.setPaymentDateTime(DateTime.now());
            if (_amount == 20) {
              DateTime dateTime = DateTime.now();
              DateTime subscription = dateTime.add(Duration(days: 30));
              payment.setSubscriptionEndDate(subscription);
            } else if (_amount == 50) {
              DateTime dateTime = DateTime.now();
              DateTime subscription = dateTime.add(Duration(days: 90));
              payment.setSubscriptionEndDate(subscription);
            } else {
              DateTime dateTime = DateTime.now();
              DateTime subscription = dateTime.add(Duration(days: 365));
              payment.setSubscriptionEndDate(subscription);
            }
            BlocProvider.of<PaymentPageBloc>(context)
                .add(ProfessionalPaymentSuccessEvent(payment: payment));
          } else {
            Payment payment = Payment.defaultConstructor();
            payment.setAmount(_amount);
            payment.setPaymentDateTime(DateTime.now());
            if (_amount == 100) {
              DateTime dateTime = DateTime.now();
              DateTime subscription = dateTime.add(Duration(days: 30));
              payment.setSubscriptionEndDate(subscription);
            } else if (_amount == 500) {
              DateTime dateTime = DateTime.now();
              DateTime subscription = dateTime.add(Duration(days: 90));
              payment.setSubscriptionEndDate(subscription);
            } else {
              DateTime dateTime = DateTime.now();
              DateTime subscription = dateTime.add(Duration(days: 365));
              payment.setSubscriptionEndDate(subscription);
            }
            BlocProvider.of<PaymentPageBloc>(context)
                .add(ProfessionalPaymentSuccessEvent(payment: payment));
          }
        } else if (page.contains('/cancel')) {
          BlocProvider.of<PaymentPageBloc>(context)
              .add(ProfessionalPaymentFailureEvent());
        }
      },
      javascriptMode: JavascriptMode.unrestricted,
      initialUrl:
          Uri.dataFromString(_loadHTML(), mimeType: 'text/html').toString(),
    );
  }

  String _loadHTML() {
    return '''
                     <html>
                       <body onload="document.f.submit();">
                         <form id="f" name="f" method="post" action="https://faheem-paypal.herokuapp.com/pay">
                           <input type="hidden" name="price" value="$_amount" />
                         </form>
                       </body>
                     </html>
                   ''';
  }

  successfulDialog() async {
    await Alert(
      context: context,
      type: AlertType.success,
      title: "Payment Success",
      desc: "Your have subscribe SMS service",
      buttons: [
        DialogButton(
          child: Text(
            "OK",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          width: 120,
        )
      ],
    ).show().then((value) {
      if (_professional != null) {
        navigateToProfessionalDashboard(context);
      } else {
        navigateToManagerDashboard(context);
      }
    });
  }

  errorDialog() async {
    await Alert(
      context: context,
      type: AlertType.error,
      title: "Payment Failue",
      desc: "You have canceled the payment",
      buttons: [
        DialogButton(
          child: Text(
            "OK",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          width: 120,
        )
      ],
    ).show().then((value) {
      navigateToProfessionalPaymentScreen(context);
    });
  }

  void navigateToProfessionalDashboard(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return ProfessionalDashboard(professional: _professional);
    }));
  }

  void navigateToProfessionalPaymentScreen(BuildContext context) {
    if (_professional != null) {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return ProfessionalPaymentScreen(professional: _professional);
      }));
    } else {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return ProfessionalPaymentScreen(manager: _manager);
      }));
    }
  }

  void navigateToManagerDashboard(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return ManagerDashboardScreen(manager: _manager);
    }));
  }
}
