import 'package:appointmentproject/model/sub_services.dart';
import 'package:meta/meta.dart';

class SubServiceRepository {
  String serviceID;

  SubServiceRepository({@required this.serviceID});

  SubServices subService = new SubServices();

  Future<List<SubServices>> getSubServicesList() async {
    return await subService.fetchSubServices(serviceID);
  }
}
