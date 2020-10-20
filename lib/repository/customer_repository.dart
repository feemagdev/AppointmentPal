import 'package:appointmentproject/model/customer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CustomerRepository {
  CustomerRepository.defaultConstructor();

  Future<List<Customer>> getAllCustomersOfProfessional(
      String professionalDocumentID) async {
    print("in get all customers");
    print(professionalDocumentID);
    final dbReference = Firestore.instance;
    List<Customer> customers = new List();
    await dbReference
        .collection('professional')
        .document(professionalDocumentID)
        .collection('customer')
        .getDocuments()
        .then((value) {
      value.documents.forEach((element) {
        print(element.data);
        Customer customer = Customer.fromMap(element.data, element.reference);
        customers.add(customer);
      });
    });
    return customers;
  }

  Future<Customer> addCustomer(
      String professionalDocumentID, String name, String phone) async {
    final dbReference = Firestore.instance;
    DocumentReference reference = await dbReference
        .collection('professional')
        .document(professionalDocumentID)
        .collection('customer')
        .add(Customer.defaultConstructor().toMap(name, phone));
    Customer customer = Customer.defaultConstructor();
    customer.setName(name);
    customer.setPhone(phone);
    customer.setDocumentReference(reference);

    if(reference.documentID.isEmpty){
      return null;
    }
    return customer;
  }
}
