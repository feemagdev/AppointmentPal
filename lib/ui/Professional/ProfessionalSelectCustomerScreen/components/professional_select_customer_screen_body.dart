import 'package:appointmentproject/BLoC/ProfessionalBloc/ProfessionalSelectCustomerBloc/professional_select_customer_bloc.dart';
import 'package:appointmentproject/model/customer.dart';
import 'package:appointmentproject/model/professional.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfessionalSelectCustomerScreenBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Professional professional;
    return Container(
      child: Column(
        children: [
          InkWell(
            onTap: ()=>print('customer add'),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.add),
                SizedBox(width: 5,),
                Text("Customer")
              ],
            ),
          ),
          BlocListener<ProfessionalSelectCustomerBloc,
              ProfessionalSelectCustomerState>(
            listener: (context, state) {},
            child: BlocBuilder<ProfessionalSelectCustomerBloc,ProfessionalSelectCustomerState>(
              builder: (context, state) {
                if (state is ProfessionalSelectCustomerInitial) {
                  professional = state.professional;
                  return loadingState(context, professional,state.selectedDateTime);
                }
                if(state is ProfessionalSelectCustomerShowAllCustomerState){
                  professional = state.professional;
                  return customerUIBuilder(state.customer, context);
                }
                return Container();
              },
            ),
          )
        ],
      ),
    );
  }

  Widget customerUIBuilder(List<Customer> customers, BuildContext context) {
    return ListView.builder(
        itemCount: customers.length,
        shrinkWrap: true,
        itemBuilder: (context, index) => customerUI(
            customers[index].getName(), customers[index].getPhone()));
  }

  Widget customerUI(String name, String phone) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.person_outline),
        SizedBox(
          width: 5,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(name),
            Text(phone),
          ],
        )
      ],
    );
  }

  Widget loadingState(BuildContext context, Professional professional,DateTime selectedDateTime) {
    BlocProvider.of<ProfessionalSelectCustomerBloc>(context).add(
        ProfessionalSelectCustomerShowAllCustomerEvent(
            professional: professional,
        selectedDateTime: selectedDateTime));

    return CircularProgressIndicator();
  }
}
