import 'package:appointmentproject/model/customer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CustomerRepository {
  CustomerRepository.defaultConstructor();

  Future<List<Customer>> getAllCustomersOfProfessional(
      String professionalID) async {
    final dbReference = FirebaseFirestore.instance;
    List<Customer> customers = new List();
    await dbReference
        .collection('professional')
        .doc(professionalID)
        .collection('customer')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        print(element.data);
        Customer customer =
            Customer.fromMap(element.data(), element.reference.id);
        customers.add(customer);
      });
    });
    return customers;
  }

  Future<Customer> addCustomer(String professionalDocumentID, String name,
      String phone, String address, String city, String country) async {
    final dbReference = FirebaseFirestore.instance;
    DocumentReference reference = await dbReference
        .collection('professional')
        .doc(professionalDocumentID)
        .collection('customer')
        .add(Customer.defaultConstructor()
            .toMap(name, phone, address, city, country));
    Customer customer = Customer.defaultConstructor();
    customer.setName(name);
    customer.setPhone(phone);
    customer.setCustomerID(reference.id);

    if (reference.id.isEmpty) {
      return null;
    }
    return customer;
  }

  Future<Customer> getCustomer(String professionalID, String customerID) async {
    final dbReference = FirebaseFirestore.instance;
    Customer customer = Customer.defaultConstructor();
    await dbReference
        .collection('professional')
        .doc(professionalID)
        .collection('customer')
        .doc(customerID)
        .get()
        .then((value) {
      customer = Customer.fromMap(value.data(), value.reference.id);
    });
    return customer;
  }

  Future<bool> checkCustomerExist(String phone, String professionalID) async {
    final dbReference = FirebaseFirestore.instance;
    QuerySnapshot snapshot = await dbReference
        .collection('professional')
        .doc(professionalID)
        .collection('customer')
        .where('phone', isEqualTo: phone)
        .get();
    return snapshot.docs.isNotEmpty;
  }
}
