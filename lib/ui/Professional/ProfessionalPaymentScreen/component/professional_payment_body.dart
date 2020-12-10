import 'package:appointmentproject/bloc/ProfessionalBloc/ProfessionalPaymentBloc/professional_payment_bloc.dart';
import 'package:appointmentproject/model/manager.dart';
import 'package:appointmentproject/model/professional.dart';
import 'package:appointmentproject/ui/Manager/ManagerSettingScreen/manager_setting_screen.dart';
import 'package:appointmentproject/ui/Professional/PayPalWebView/paypal_web_view_screen.dart';
import 'package:appointmentproject/ui/Professional/SettingScreen/setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ProfessionalPaymentBody extends StatefulWidget {
  @override
  _ProfessionalPaymentBodyState createState() =>
      _ProfessionalPaymentBodyState();
}

class _ProfessionalPaymentBodyState extends State<ProfessionalPaymentBody> {
  bool monthlySelected = true;
  bool quartelySelected = false;
  bool yearlySelected = false;
  Manager _manager;
  @override
  Widget build(BuildContext context) {
    _manager = BlocProvider.of<ProfessionalPaymentBloc>(context).manager;
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text("Select Package"),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Professional professional =
                    BlocProvider.of<ProfessionalPaymentBloc>(context)
                        .professional;
                if (professional != null) {
                  navigateToProfessionalSettingScreen(context, professional);
                } else {
                  navigateToManagerSettingScreen(context, _manager);
                }
              },
            ),
          ),
          body: Stack(
            children: [
              BlocListener<ProfessionalPaymentBloc, ProfessionalPaymentState>(
                listener: (context, state) {
                  if (state is ProfessionalAddPaymentState) {
                    Professional professional =
                        BlocProvider.of<ProfessionalPaymentBloc>(context)
                            .professional;
                    navigateToPayPalWebViewScreen(
                        context, state.amount, professional, _manager);
                  } else if (state is ProfessionalPaymentAlreadyPaidState) {
                    infoDialog();
                  }
                },
                child: BlocBuilder<ProfessionalPaymentBloc,
                    ProfessionalPaymentState>(builder: (context, state) {
                  if (state is ProfessionalPaymentInitial) {
                    return paymentBuilderUI();
                  }
                  return paymentBuilderUI();
                }),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget paymentBuilderUI() {
    return Stack(
      children: [paymentUI(), paymentButton()],
    );
  }

  Widget paymentButton() {
    return Align(
      alignment: Alignment.center,
      child: Container(
        height: 50,
        child: RaisedButton(
          color: Colors.blue,
          onPressed: () {
            if (monthlySelected) {
              BlocProvider.of<ProfessionalPaymentBloc>(context).add(
                  ProfessionalPaymentButtonEvent(
                      amount: _manager != null ? 100 : 20));
            } else if (quartelySelected) {
              BlocProvider.of<ProfessionalPaymentBloc>(context).add(
                  ProfessionalPaymentButtonEvent(
                      amount: _manager != null ? 500 : 50));
            } else {
              BlocProvider.of<ProfessionalPaymentBloc>(context).add(
                  ProfessionalPaymentButtonEvent(
                      amount: _manager != null ? 1000 : 100));
            }
          },
          child: Text(
            "Pay with PayPal",
            style:
                TextStyle(fontSize: 17, color: Colors.white, letterSpacing: 1),
          ),
        ),
      ),
    );
  }

  Widget paymentUI() {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                monthlySelected = true;
                quartelySelected = false;
                yearlySelected = false;
              });
            },
            child: Container(
                width: deviceWidth * 0.25,
                height: deviceHeight * 0.20,
                decoration: BoxDecoration(
                    color: monthlySelected == true ? Colors.blue : Colors.white,
                    border: Border.all(color: Colors.blue),
                    borderRadius: BorderRadius.all(Radius.circular(25))),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Monthly",
                        style: TextStyle(
                          color: monthlySelected == true
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                      Text(
                        _manager != null ? "100 USD" : "20 USD",
                        style: TextStyle(
                          color: monthlySelected == true
                              ? Colors.white
                              : Colors.black,
                        ),
                      )
                    ],
                  ),
                )),
          ),
          SizedBox(
            height: 5,
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                monthlySelected = false;
                quartelySelected = true;
                yearlySelected = false;
              });
            },
            child: Container(
                width: deviceWidth * 0.25,
                height: deviceHeight * 0.20,
                decoration: BoxDecoration(
                    color:
                        quartelySelected == true ? Colors.blue : Colors.white,
                    border: Border.all(color: Colors.blue),
                    borderRadius: BorderRadius.all(Radius.circular(25))),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Quarterly",
                        style: TextStyle(
                          color: quartelySelected == true
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                      Text(
                        _manager != null ? "500 USD" : "50 USD",
                        style: TextStyle(
                          color: quartelySelected == true
                              ? Colors.white
                              : Colors.black,
                        ),
                      )
                    ],
                  ),
                )),
          ),
          SizedBox(
            height: 5,
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                monthlySelected = false;
                quartelySelected = false;
                yearlySelected = true;
              });
            },
            child: Container(
                width: deviceWidth * 0.25,
                height: deviceHeight * 0.20,
                decoration: BoxDecoration(
                    color: yearlySelected == true ? Colors.blue : Colors.white,
                    border: Border.all(color: Colors.blue),
                    borderRadius: BorderRadius.all(Radius.circular(25))),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Yearly",
                        style: TextStyle(
                          color: yearlySelected == true
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                      Text(
                        _manager != null ? "1000 USD" : "100 USD",
                        style: TextStyle(
                          color: yearlySelected == true
                              ? Colors.white
                              : Colors.black,
                        ),
                      )
                    ],
                  ),
                )),
          ),
        ],
      ),
    );
  }

  infoDialog() async {
    await Alert(
      context: context,
      type: AlertType.info,
      title: "Payment Paid",
      desc: "You have already paid for the service",
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
    ).show().then((value) {});
  }

  void navigateToPayPalWebViewScreen(BuildContext context, int amount,
      Professional professional, Manager manager) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return PaypalWebViewScreen(
          amount: amount, professional: professional, manager: manager);
    }));
  }

  void navigateToProfessionalSettingScreen(
      BuildContext context, Professional professional) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return SettingScreen(professional: professional);
    }));
  }

  void navigateToManagerSettingScreen(BuildContext context, Manager manager) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return ManagerSettingScreen(manager: manager);
    }));
  }
}
