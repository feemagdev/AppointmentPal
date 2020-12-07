import 'dart:async';
import 'dart:io';

import 'package:appointmentproject/model/company.dart';
import 'package:appointmentproject/model/manager.dart';
import 'package:appointmentproject/repository/company_repository.dart';
import 'package:appointmentproject/repository/manager_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'company_profile_event.dart';
part 'company_profile_state.dart';

class CompanyProfileBloc
    extends Bloc<CompanyProfileEvent, CompanyProfileState> {
  final Manager manager;
  CompanyProfileBloc({@required this.manager});
  @override
  Stream<CompanyProfileState> mapEventToState(
    CompanyProfileEvent event,
  ) async* {
    if (event is GetComapanyDetailsEvent) {
      yield CompanyProfileLoadingState();
      if (manager.getCompanyID() == null) {
        yield NoCompanyRegisteredState();
      } else {
        Company company = await ComapanyRepository.defaultConstructor()
            .getCompanyDetails(manager.getCompanyID());
        yield GetCompanyDetailState(company: company);
      }
    } else if (event is UpdateCompanyImageEvent) {
      yield CompanyProfileLoadingState();

      await ComapanyRepository.defaultConstructor().uploadImageToFirebase(
          event.imageFile,
          event.company.getCompanyID(),
          event.company.getImage());
      Company company = await ComapanyRepository.defaultConstructor()
          .getCompanyDetails(manager.getCompanyID());
      yield CompanyImageUpdateSuccessfullyState();
      yield GetCompanyDetailState(company: company);
    } else if (event is UpdateCompanyDetailEvent) {
      yield CompanyProfileLoadingState();
      if (manager.getCompanyID() == null) {
        Company company = await ComapanyRepository.defaultConstructor()
            .addCompany(
                name: event.company.getName(),
                contact: event.company.getContact(),
                address: event.company.getCompanyAddress());
        ManagerRepository.defaultConstructor()
            .updateManager(manager.getManagerID(), company.getCompanyID());
        manager.setCompanyID(company.getCompanyID());
        yield CompanyAddedSuccessfullyState();
        yield GetCompanyDetailState(company: company);
      } else {
        ComapanyRepository.defaultConstructor()
            .updateCompanyDetail(event.company);

        Company company = await ComapanyRepository.defaultConstructor()
            .getCompanyDetails(manager.getCompanyID());
        yield CompanyUpdateSuccessfullyState();
        yield GetCompanyDetailState(company: company);
      }
    }
  }

  @override
  CompanyProfileState get initialState => CompanyProfileInitial();
}
