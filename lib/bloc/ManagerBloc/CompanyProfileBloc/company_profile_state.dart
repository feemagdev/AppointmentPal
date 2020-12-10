part of 'company_profile_bloc.dart';

abstract class CompanyProfileState {}

class CompanyProfileInitial extends CompanyProfileState {}

class CompanyProfileLoadingState extends CompanyProfileState {}

class GetCompanyDetailState extends CompanyProfileState {
  final Company company;
  GetCompanyDetailState({@required this.company});
}

class CompanyUpdateSuccessfullyState extends CompanyProfileState {}

class CompanyImageUpdateSuccessfullyState extends CompanyProfileState {}

class NoCompanyRegisteredState extends CompanyProfileState {}

class CompanyAddedSuccessfullyState extends CompanyProfileState {}
