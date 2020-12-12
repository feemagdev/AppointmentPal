import 'package:appointmentproject/model/payment.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PaymentRepository {
  PaymentRepository.defualtConstructor();

  Future<bool> professionalCreatePayment(
      Payment payment, String professionalID) async {
    final dbReference = FirebaseFirestore.instance;
    Map map = payment.professionalMap(
        paymentDateTime: payment.getPaymentDateTime(),
        professionalID: professionalID,
        subscriptionEndDate: payment.getSubscriptionEndDate(),
        amount: payment.getAmount());
    dbReference.collection('payment').add(map);
    return true;
  }

  Future<bool> managerCreatePayment(Payment payment, String managerID) async {
    final dbReference = FirebaseFirestore.instance;
    Map map = payment.managerMap(
        paymentDateTime: payment.getPaymentDateTime(),
        managerID: managerID,
        subscriptionEndDate: payment.getSubscriptionEndDate(),
        amount: payment.getAmount());
    dbReference.collection('payment').add(map);
    return true;
  }

  Future<bool> getProfessionalPaymentStatus(String professionalID) async {
    final dbReference = FirebaseFirestore.instance;
    QuerySnapshot snapshot = await dbReference
        .collection('payment')
        .where('subscription_end_date', isGreaterThan: DateTime.now())
        .where('professionalID', isEqualTo: professionalID)
        .get();
    if (snapshot.size == 0) {
      print("snapshot size is zero");
      return true;
    } else {
      return false;
    }
  }

  Future<bool> getManagerPaymentStatus(String managerID) async {
    final dbReference = FirebaseFirestore.instance;
    QuerySnapshot snapshot = await dbReference
        .collection('payment')
        .where('subscription_end_date', isGreaterThan: DateTime.now())
        .where('managerID', isEqualTo: managerID)
        .get();
    if (snapshot.size == 0) {
      return true;
    } else {
      return false;
    }
  }
}
