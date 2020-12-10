import 'package:appointmentproject/bloc/ProfessionalBloc/ProfessionalSelectClientBloc/professional_select_client_bloc.dart';
import 'package:appointmentproject/model/customer.dart';

import 'package:appointmentproject/model/professional.dart';
import 'package:appointmentproject/ui/Professional/CustomerDetailScreen/customer_detail_screen.dart';

import 'package:appointmentproject/ui/Professional/ProfessionalDashboard/professional_dashboard_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfessionalSelectClientBody extends StatefulWidget {
  @override
  _ProfessionalSelectClientBodyState createState() =>
      _ProfessionalSelectClientBodyState();
}

class _ProfessionalSelectClientBodyState
    extends State<ProfessionalSelectClientBody> {
  List<Customer> customerList = List();
  List<Customer> filteredCustomers = List();
  @override
  Widget build(BuildContext context) {
    final Professional _professional =
        BlocProvider.of<ProfessionalSelectClientBloc>(context).professional;

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text("Select Client"),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                navigateToProfessionalDashboardScreen(context, _professional);
              },
            ),
          ),
          resizeToAvoidBottomPadding: false,
          body: Stack(
            children: [
              BlocListener<ProfessionalSelectClientBloc,
                  ProfessionalSelectClientState>(
                listener: (context, state) {
                  if (state is ClientSelectedState) {
                    navigateToCustomerDetailScreen(
                        context, state.customer, _professional);
                  }
                },
                child: BlocBuilder<ProfessionalSelectClientBloc,
                    ProfessionalSelectClientState>(
                  builder: (context, state) {
                    if (state is ProfessionalSelectClientInitial) {
                      BlocProvider.of<ProfessionalSelectClientBloc>(context)
                          .add(GetClientListEvent());
                      return Container();
                    } else if (state is ClientSearchingState) {
                      customerList = state.customerList;
                      filteredCustomers = state.filteredList;
                      return professionalSelectClientUI();
                    } else if (state is GetClientListState) {
                      customerList = state.customers;
                      filteredCustomers = state.customers;
                      return professionalSelectClientUI();
                    } else if (state is ProfessionalSelectClientLoadingState) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is NoCustomerFoundState) {
                      return Center(child: Text("Sorry You have no clients"));
                    }
                    return Container();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget professionalSelectClientUI() {
    return Column(
      children: [
        searchTextField(),
        listOfCustomers(),
      ],
    );
  }

  Widget getCustomers(context) {
    BlocProvider.of<ProfessionalSelectClientBloc>(context)
        .add(GetClientListEvent());
    return Container();
  }

  Widget searchTextField() {
    return TextField(
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(15.0),
        hintText: 'Filter by name or phone',
      ),
      onChanged: (string) {
        BlocProvider.of<ProfessionalSelectClientBloc>(context).add(
            ClientSearchingEvent(customerList: customerList, query: string));
      },
    );
  }

  Widget listOfCustomers() {
    return Expanded(
      child: SingleChildScrollView(
        child: ListView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.all(10.0),
          itemCount: filteredCustomers.length,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {
                BlocProvider.of<ProfessionalSelectClientBloc>(context).add(
                    ProfessionalSelectedClientEvent(
                        customer: filteredCustomers[index]));
              },
              child: Card(
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        filteredCustomers[index].getName(),
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        filteredCustomers[index].getPhone().toLowerCase(),
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void navigateToProfessionalDashboardScreen(
      BuildContext context, Professional professional) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return ProfessionalDashboard(
        professional: professional,
      );
    }));
  }

  void navigateToCustomerDetailScreen(
      BuildContext context, Customer customer, Professional professional) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return CustomerDetailScreen(
          customer: customer, professional: professional);
    }));
  }
}
