

import 'package:appointmentproject/BLoC/SearchProfessional/bloc.dart';
import 'package:appointmentproject/ui/SearchProfessioanl/components/body.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';


class SearchProfessionalScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchProfessionalBloc(),
      child: Scaffold(
        body: Body(),
      ),
    );
  }
}


