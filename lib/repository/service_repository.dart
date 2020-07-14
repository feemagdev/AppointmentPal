import 'package:appointmentproject/model/service.dart';

class ServiceRepository {

  Service service = new Service();

  Future<List<Service>> getServicesList() async{
    return await service.serviceList();
  }


}