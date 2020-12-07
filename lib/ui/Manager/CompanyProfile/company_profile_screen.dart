import 'package:appointmentproject/bloc/ManagerBloc/CompanyProfileBloc/company_profile_bloc.dart';
import 'package:appointmentproject/model/manager.dart';
import 'package:appointmentproject/ui/Manager/CompanyProfile/components/company_profile_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CompanyProfileScreen extends StatelessWidget {
  final Manager manager;
  CompanyProfileScreen({@required this.manager});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => CompanyProfileBloc(manager: manager),
        child: CompanyProfileBody());
  }
}
