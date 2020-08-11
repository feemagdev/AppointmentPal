import 'package:appointmentproject/model/service.dart';
import 'package:meta/meta.dart';

class ServiceRepository {
  String name;
  String image;

  ServiceRepository({@required this.name,@required this.image});

  ServiceRepository.defaultConstructor();


  Future<List<Service>> getServicesList(String need) async{
    return await Service.defaultConstructor().getServices(need);
  }


}