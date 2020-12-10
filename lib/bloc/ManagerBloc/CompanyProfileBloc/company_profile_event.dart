part of 'company_profile_bloc.dart';

abstract class CompanyProfileEvent {}

class GetComapanyDetailsEvent extends CompanyProfileEvent {}

class UpdateCompanyImageEvent extends CompanyProfileEvent {
  final File imageFile;
  final Company company;
  UpdateCompanyImageEvent({@required this.imageFile, @required this.company});
}

class UpdateCompanyDetailEvent extends CompanyProfileEvent {
  final Company company;
  UpdateCompanyDetailEvent({@required this.company});
}
