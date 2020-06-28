import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Professional extends Equatable{

  final String name;
  final String phone;
  final String profession;
  final String service;
  final String uid;


  Professional({
    @required this.name,
    @required this.phone,
    @required this.profession,
    @required this.service,
    @required this.uid});

  @override
  // TODO: implement props
  List<Object> get props => null;

  Map<String, Object> toJson(){
    return{
      'name':name,
      'phone':phone,
      'profession':profession,
      'service':service,
      'uid':uid
    };
  }


}