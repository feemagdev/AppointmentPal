import 'package:appointmentproject/bloc/CompleteDetailBloc/complete_detail_bloc.dart';
import 'package:appointmentproject/ui/Client/CompleteDetails/components/complete_details_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CompleteDetailScreen extends StatelessWidget {
  final String uid;
  CompleteDetailScreen({@required this.uid});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CompleteDetailBloc(uid: uid),
      child: CompleteDetailBody(),
    );
  }
}
