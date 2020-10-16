


import 'package:appointmentproject/model/customer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CustomerRepository {
  
  CustomerRepository.defaultConstructor();
  
  
  Future<List<Customer>> getAllCustomersOfProfessional(String professionalDocumentID) async{
    print("in get all customers");
    print(professionalDocumentID);
    final dbReference = Firestore.instance;
    List<Customer> customers = new List();
    await dbReference.collection('professional').document(professionalDocumentID).collection('customer').getDocuments().then((value){
      value.documents.forEach((element) {
        print(element.data);
        Customer customer = Customer.fromMap(element.data, element.reference);
        customers.add(customer);
      });
    });
    return customers;
  }
  
  
  
  
}