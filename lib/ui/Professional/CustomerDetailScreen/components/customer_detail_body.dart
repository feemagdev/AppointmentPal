import 'package:appointmentproject/bloc/ProfessionalBloc/CustomerDetailBloc/customer_detail_bloc.dart';
import 'package:appointmentproject/model/customer.dart';
import 'package:appointmentproject/model/professional.dart';
import 'package:appointmentproject/ui/Professional/ProfessionalViewClient/professional_select_client_sceen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomerDetailBody extends StatefulWidget {
  @override
  _CustomerDetailBodyState createState() => _CustomerDetailBodyState();
}

class _CustomerDetailBodyState extends State<CustomerDetailBody> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _countryController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Customer _customer = BlocProvider.of<CustomerDetailBloc>(context).customer;
    Professional _professional =
        BlocProvider.of<CustomerDetailBloc>(context).professional;
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text("Client Details"),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                navigateToSelectClientScreen(context, _professional);
              },
            ),
          ),
          body: Stack(
            children: [
              BlocListener<CustomerDetailBloc, CustomerDetailState>(
                listener: (context, state) {},
                child: BlocBuilder<CustomerDetailBloc, CustomerDetailState>(
                  builder: (context, state) {
                    if (state is CustomerDetailInitial) {
                      _nameController.text = _customer.getName();
                      _phoneController.text = _customer.getPhone();
                      _addressController.text = _customer.getAddress();
                      _cityController.text = _customer.getCity();
                      _countryController.text = _customer.getCountry();

                      return customerProfileUI();
                    }
                    return customerProfileUI();
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget customerProfileUI() {
    double deviceHeight = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Icon(
          Icons.person,
          size: deviceHeight * 0.20,
          color: Colors.blue,
        ),
        Expanded(child: SingleChildScrollView(child: customerDetailUI())),
      ],
    );
  }

  Widget customerDetailUI() {
    double deviceWidth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                  blurRadius: 6.0, color: Colors.grey, offset: Offset(0.0, 1.0))
            ]),
            height: deviceWidth < 365 ? 80 : 80,
            child: Padding(
              padding:
                  const EdgeInsets.only(top: 10, left: 5, right: 0, bottom: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Name",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextField(
                    controller: _nameController,
                    readOnly: true,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                    ),
                    keyboardType: TextInputType.name,
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                  blurRadius: 6.0, color: Colors.grey, offset: Offset(0.0, 1.0))
            ]),
            height: deviceWidth < 365 ? 80 : 80,
            child: Padding(
              padding:
                  const EdgeInsets.only(top: 10, left: 5, right: 0, bottom: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Phone",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextField(
                    controller: _phoneController,
                    readOnly: true,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                    ),
                    keyboardType: TextInputType.phone,
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                  blurRadius: 6.0, color: Colors.grey, offset: Offset(0.0, 1.0))
            ]),
            height: deviceWidth < 365 ? 80 : 80,
            child: Padding(
              padding:
                  const EdgeInsets.only(top: 10, left: 5, right: 0, bottom: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Address",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextField(
                    controller: _addressController,
                    readOnly: true,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                    ),
                    keyboardType: TextInputType.streetAddress,
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                  blurRadius: 6.0, color: Colors.grey, offset: Offset(0.0, 1.0))
            ]),
            height: deviceWidth < 365 ? 80 : 80,
            child: Padding(
              padding:
                  const EdgeInsets.only(top: 10, left: 5, right: 0, bottom: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "City",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextField(
                    controller: _cityController,
                    readOnly: true,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                    ),
                    keyboardType: TextInputType.text,
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                  blurRadius: 6.0, color: Colors.grey, offset: Offset(0.0, 1.0))
            ]),
            height: deviceWidth < 365 ? 80 : 80,
            child: Padding(
              padding:
                  const EdgeInsets.only(top: 10, left: 5, right: 0, bottom: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Country",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextField(
                    controller: _countryController,
                    readOnly: true,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                    ),
                    keyboardType: TextInputType.text,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  void navigateToSelectClientScreen(
      BuildContext context, Professional professional) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return ProfessionalSelectClientScreen(professional: professional);
      },
    ));
  }
}
